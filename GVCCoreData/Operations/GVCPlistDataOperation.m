/*
 * GVCPlistDataOperation.m
 * 
 * Created by David Aspinall on 2013-02-17. 
 * Copyright (c) 2013 Global Village Consulting. All rights reserved.
 *
 */

#import "GVCPlistDataOperation.h"
#import "NSManagedObject+GVCCoreData.h"
#import "NSEntityDescription+GVCCoreData.h"

GVC_DEFINE_STRVALUE(GVCPlistDataOperation__NULL, __NULL__);
GVC_DEFINE_STRVALUE(GVCPlistDataOperation_attributeNames, attributeNames);
GVC_DEFINE_STRVALUE(GVCPlistDataOperation_rows, rows);

GVC_DEFINE_STRVALUE(GVCPlistDataOperation_relationships, relationships);
GVC_DEFINE_STRVALUE(GVCPlistDataOperation_relationshipName, relationshipName);
GVC_DEFINE_STRVALUE(GVCPlistDataOperation_sourceAttributes, sourceAttributes);
GVC_DEFINE_STRVALUE(GVCPlistDataOperation_destinationAttributes, destinationAttributes);

@interface GVCPlistDataOperation ()
@end

@implementation GVCPlistDataOperation

- (id)initForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator usingFile:(NSString *)file;
{
	self = [super initForPersistentStoreCoordinator:coordinator];
	if ( self != nil )
	{
        [self setLoadFile:file];
	}
	
    return self;
}

- (void)main
{
	[self initializeCoreData];
    
	[self operationDidStart];
	NSError *anError = nil;
	NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:[self loadFile]];
    if ([self parsePlist:plistDictionary error:&anError] == YES)
    {
        [self operationDidFinish];
    }
    else
    {
		if ( anError == nil )
			anError = [self operationError];
        [self operationDidFailWithError:anError];
    }
}

- (NSEntityDescription *)entityForName:(NSString *)name
{
	return [NSEntityDescription entityForName:name inManagedObjectContext:[self managedObjectContext]];
}

- (BOOL)parsePlist:(NSDictionary *)plistDictionary error:(NSError **)anError
{
	BOOL success = YES;
	if (plistDictionary == nil)
	{
		success = NO;
		if ( anError != NULL )
			*anError = [NSError errorWithDomain:GVCOperationErrorDomain code:-1 userInfo:nil];
	}
	else
	{
		NSMutableDictionary *relationshipsToResolve = [NSMutableDictionary dictionaryWithCapacity:[plistDictionary count]];
		// first level keys are entity names
		for (NSString *entityName in [plistDictionary allKeys])
		{
			GVC_ASSERT_NOT_NIL([self entityForName:entityName]);
			NSEntityDescription *entity = [self entityForName:entityName];
			
			NSDictionary *dataDictionary = [plistDictionary valueForKey:entityName];
			NSArray *attributeKeys = [dataDictionary valueForKey:GVCPlistDataOperation_attributeNames];
			NSArray *rows = [dataDictionary valueForKey:GVCPlistDataOperation_rows];
			
			GVC_ASSERT_NOT_EMPTY(attributeKeys);
			GVC_ASSERT_NOT_NIL(rows);

			for (NSArray *aRow in rows)
			{
				GVC_ASSERT_NOT_EMPTY(aRow);
				GVC_ASSERT([aRow count] == [attributeKeys count], @"Row and attributes have different number of records");

				success = [self loadRow:aRow forEntity:entity withAttributes:attributeKeys error:anError];
				if (success == NO)
				{
					break;
				}
			}
			
			NSArray *relationships = [dataDictionary valueForKey:GVCPlistDataOperation_relationships];
			if ( gvc_IsEmpty(relationships) == NO)
			{
				[relationshipsToResolve setValue:relationships forKey:entityName];
			}
			
			if ( success == NO )
			{
				break;
			}
		}
		
		// now that all entities are loaded and saved, resolve the relationships
		if ((success == YES) && (gvc_IsEmpty(relationshipsToResolve) == NO))
		{
			for (NSString *entityName in [plistDictionary allKeys])
			{
				NSEntityDescription *entity = [self entityForName:entityName];
				NSArray *relationships = [relationshipsToResolve valueForKey:entityName];

				// since CoreData doesn't do mass updates we have to pull all the records into memory
				if ((success == YES) && (gvc_IsEmpty(relationships) == NO))
				{
					NSArray *sourceRecords = [NSManagedObject gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
					
					for (NSDictionary *relation in relationships)
					{
						GVC_ASSERT_NOT_EMPTY(relation);
						
						success = [self resolveRelationship:relation forRecords:sourceRecords entity:entity  error:anError];
						if (success == NO)
						{
							break;
						}
					}
				}
			}
		}
	}
	
	return success;
}

- (BOOL)loadRow:(NSArray *)aRow forEntity:(NSEntityDescription *)entity withAttributes:(NSArray *)attributeKeys error:(NSError **)anError
{
	NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:[self managedObjectContext]];
	NSUInteger count = [attributeKeys count];
	for (NSUInteger i = 0; i < count; i++)
	{
		NSString *key = [attributeKeys objectAtIndex:i];
		GVC_ASSERT([entity gvc_attributeNamed:key] != nil, @"Could not find attribute %@.%@", [entity name], key);

		NSObject *value = [aRow objectAtIndex:i];
		if (([value isKindOfClass:[NSString class]] == YES) && ([(NSString *)value isEqualToString:GVCPlistDataOperation__NULL] == YES))
		{
			[mo setValue:nil forKey:key];
		}
		else
		{
			[mo gvc_setConvertedValue:value forKey:key];			
		}
	}

	return [self saveContext];
}


- (BOOL)resolveRelationship:(NSDictionary *)relation forRecords:(NSArray *)sourceRecords entity:(NSEntityDescription *)entity error:(NSError **)anError
{
	NSString *relationshipName = [relation objectForKey:GVCPlistDataOperation_relationshipName];
	GVC_ASSERT_NOT_EMPTY(relationshipName);
	GVC_ASSERT([entity gvc_relationshipNamed:relationshipName] != nil, @"Could not find relationship name %@.%@", [entity name], relationshipName);

	NSRelationshipDescription *relationDesc = [entity gvc_relationshipNamed:relationshipName];
	NSEntityDescription *destination = [relationDesc destinationEntity];
	NSArray *sourceAttributes = [relation valueForKey:GVCPlistDataOperation_sourceAttributes];
	NSArray *destinationAttributes = [relation valueForKey:GVCPlistDataOperation_destinationAttributes];
	GVC_ASSERT_NOT_EMPTY(sourceAttributes);
	GVC_ASSERT_NOT_EMPTY(destinationAttributes);
	GVC_ASSERT([sourceAttributes count] == [destinationAttributes count], @"%@ relationship %@ has different number of attributes", [entity name], relationshipName);

	// quick validation of attribute names
	for (NSUInteger i = 0; i < [sourceAttributes count]; i++)
	{
		NSString *srcAtt = [sourceAttributes objectAtIndex:i];
		NSString *dstAtt = [destinationAttributes objectAtIndex:i];
		
		GVC_ASSERT([entity gvc_attributeNamed:srcAtt] != nil, @"Could not find relationship attribute name %@.%@ (%@)", [entity name], relationshipName, srcAtt);
		GVC_ASSERT([destination gvc_attributeNamed:dstAtt] != nil, @"Could not find destination relationship attribute name %@.%@ (%@)", [entity name], relationshipName, dstAtt);
	}
	
	for (NSManagedObject *record in sourceRecords)
	{
		// construct a predicate for the destination entity, using the values from the source
		NSMutableDictionary *qualifier = [NSMutableDictionary dictionaryWithCapacity:[sourceAttributes count]];

		for (NSUInteger i = 0; i < [sourceAttributes count]; i++)
		{
			NSString *srcAtt = [sourceAttributes objectAtIndex:i];
			NSString *dstAtt = [destinationAttributes objectAtIndex:i];
			
			NSObject *qualValue = [record valueForKey:srcAtt];
			[qualifier setValue:qualValue forKey:dstAtt];
		}

		if ( [relationDesc isToMany] == NO )
		{
			NSManagedObject *mo = [NSManagedObject gvc_findObject:destination forKeyValue:qualifier inContext:[self managedObjectContext]];
			[record setValue:mo forKey:[relationDesc name]];
		}
		else
		{
			NSMutableSet *mutableSet = [record mutableSetValueForKey:[relationDesc name]];
			NSArray *destArray = [NSManagedObject gvc_findAllObjects:destination forKeyValue:qualifier inContext:[self managedObjectContext]];
			for (NSManagedObject *mo in destArray)
			{
				[mutableSet addObject:mo];
			}
		}
	}
	
	return [self saveContext];
}

@end
