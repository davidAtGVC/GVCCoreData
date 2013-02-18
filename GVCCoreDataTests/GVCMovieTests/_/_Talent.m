// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Talent.m instead.

#import "_Talent.h"

const struct TalentAttributes TalentAttributes = {
	.firstName = @"firstName",
	.lastName = @"lastName",
	.talentID = @"talentID",
};

const struct TalentRelationships TalentRelationships = {
	.moviesDirected = @"moviesDirected",
	.photo = @"photo",
	.roles = @"roles",
};

const struct TalentFetchedProperties TalentFetchedProperties = {
};

@implementation TalentID
@end

@implementation _Talent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Talent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Talent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Talent" inManagedObjectContext:moc_];
}

- (TalentID*)objectID {
	return (TalentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"talentIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"talentID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic firstName;






@dynamic lastName;






@dynamic talentID;



- (int64_t)talentIDValue {
	NSNumber *result = [self talentID];
	return [result longLongValue];
}

- (void)setTalentIDValue:(int64_t)value_ {
	[self setTalentID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveTalentIDValue {
	NSNumber *result = [self primitiveTalentID];
	return [result longLongValue];
}

- (void)setPrimitiveTalentIDValue:(int64_t)value_ {
	[self setPrimitiveTalentID:[NSNumber numberWithLongLong:value_]];
}





@dynamic moviesDirected;

	
- (NSMutableSet*)moviesDirectedSet {
	[self willAccessValueForKey:@"moviesDirected"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"moviesDirected"];
  
	[self didAccessValueForKey:@"moviesDirected"];
	return result;
}
	

@dynamic photo;

	

@dynamic roles;

	
- (NSMutableSet*)rolesSet {
	[self willAccessValueForKey:@"roles"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"roles"];
  
	[self didAccessValueForKey:@"roles"];
	return result;
}
	






@end
