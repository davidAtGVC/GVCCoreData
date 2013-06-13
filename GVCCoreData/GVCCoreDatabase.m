/*
 * GVCCoreDatabase.m
 * 
 * Created by David Aspinall on 2013-02-17. 
 * Copyright (c) 2013 __MyCompanyName__. All rights reserved.
 *
 */

#import "GVCCoreDatabase.h"
#import <GVCFoundation/GVCFoundation.h>

@interface GVCCoreDatabase ()
- (id)initWithModel:(NSString *)modelName purgeFailedMigrations:(BOOL)purge;
@end

static NSMutableDictionary *databasesByEntityName = nil;


@implementation GVCCoreDatabase

+ (void)initialize
{
	static dispatch_once_t sharedDispatch;
	dispatch_once(&sharedDispatch, ^{
		databasesByEntityName = [[NSMutableDictionary alloc] initWithCapacity:1];
	});
}

+ (id)databaseForModelName:(NSString *)modelName purgeFailedMigrations:(BOOL)purge
{
	GVCCoreDatabase *database = [databasesByEntityName objectForKey:modelName];
	if ( database == nil )
	{
		database = [[[self class] alloc] initWithModel:modelName purgeFailedMigrations:purge];
		[databasesByEntityName setObject:database forKey:modelName];
	}
	return database;
}

+ (GVCCoreDatabase *)databaseForModelName:(NSString *)modelName
{
	return [self databaseForModelName:modelName purgeFailedMigrations:YES];
}

+ (GVCCoreDatabase *)findDatabaseForEntity:(NSEntityDescription *)entity
{
	return [self findDatabaseForEntityName:[entity name]];
}

+ (GVCCoreDatabase *)findDatabaseForEntityName:(NSString *)entityName
{
	GVCCoreDatabase *found = nil;
	NSArray *allDatabases = [self allDatabases];
	for (GVCCoreDatabase *database in allDatabases)
	{
		NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName inManagedObjectContext:[database managedObjectContext]];
		if ( entityDesc != nil )
		{
			found = database;
			break;
		}
	}
	return found;
}

+ (NSArray *)allDatabases
{
	return [databasesByEntityName allValues];
}

- (id)initWithModel:(NSString *)modelName purgeFailedMigrations:(BOOL)purge
{
    self = [super init];
    if (self != nil)
	{
		GVC_ASSERT([databasesByEntityName objectForKey:modelName] == nil, @"Database for model %@ is already initialized", modelName);
		
		NSString *momdPath = [[NSBundle bundleForClass:[self class]] pathForResource:modelName ofType:@"momd"];
		GVC_ASSERT_NOT_EMPTY(momdPath);
		
		NSURL *modelURL = [NSURL fileURLWithPath:momdPath];
		
		NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
		
		NSMutableSet *entities = [NSMutableSet setWithArray:[model entitiesForConfiguration:modelName]];
		NSSet *modelset = [NSSet setWithArray:[model entities]];
		[entities minusSet:modelset];
		GVC_ASSERT(gvc_IsEmpty(entities), @"Configuration does not include all entities %@", entities);
		
		[self setManagedObjectModel:model];
		[self setPersistentStoreCoordinator:[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]]];
		
		NSManagedObjectContext *moContext = [[NSManagedObjectContext alloc] init];
		[moContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
		
		// TODO: check for database version and upgrade
		// maybe each model should have a version and a ModelUpgrade class
		// example [BucketsModel upgradeDatabase:moc];
		// [self upgradeDatabase];
		// [moContext setUndoManager:[[NSUndoManager  alloc] init]];
		[moContext setUndoManager:nil];
		[self setManagedObjectContext:moContext];
		
		[self initializeSQLiteDatabase:modelName purgeFailedMigrations:purge];
    }
    return self;
}


- (void)initializeSQLiteDatabase:(NSString *)modelName purgeFailedMigrations:(BOOL)purge
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *err = nil;
	NSURL *storeURL = [[GVCDirectory DocumentDirectory] fullURLForFile:GVC_SPRINTF(@"%@.sqlite", modelName)];
	
	[self installSampleDatabase:modelName toURL:storeURL];
	
	if ([[self persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:modelName URL:storeURL options:nil error:&err] == nil)
	{
		GVCLogError( @"Failed to load sqlite %@", storeURL);
		
		// remove the datafile and try re-installing the sample
		if ((purge == YES) && ([fileManager removeItemAtURL:storeURL error:&err] == YES))
		{
			[self installSampleDatabase:modelName toURL:storeURL];
			
			if ([[self persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:modelName URL:storeURL options:nil error:&err] == nil)
			{
				GVC_ASSERT(NO, @"Failed to allocate persistent store for %@.  Error %@", storeURL, [err description]);
			}
		}
		else
		{
			GVC_ASSERT(NO, @"Failed to allocate persistent store for %@.  Error %@", storeURL, [err description]);
		}
	}
}

- (void)installSampleDatabase:(NSString *)modelName toURL:(NSURL *)storeURL
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *err = nil;
	// copy in sample data files if they exist
	
	BOOL installSample = NO;
	
	// is there a sample to install
	NSString *sample = [[NSBundle mainBundle] pathForResource:modelName ofType:@"sqlite"];
	if ( gvc_IsEmpty(sample) == NO )
	{
		if ( [fileManager fileExistsAtPath:[storeURL path]] == NO )
		{
			installSample = YES;
		}
		else
		{
			GVCFile *source = [GVCFile fileWithAbsolutePath:sample];
			GVCFile *destination = [GVCFile fileWithAbsolutePath:[storeURL path]];
			
			if (([source fileSize] > [destination fileSize]) || ([[source fileModificationDate] gvc_isLaterThanDate:[destination fileModificationDate]] == YES))
			{
				installSample = [fileManager removeItemAtURL:storeURL error:&err];
				if (installSample == NO)
				{
					GVCLogNSError(GVCLoggerLevel_ERROR, err);
				}
			}
		}
	}
	
	
	if ( installSample == YES )
	{
		GVCLogError( @"Installing sample database %@", sample);
		[fileManager copyItemAtPath:sample toPath:[storeURL path] error:nil];
		
		NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
		
		// Create one coordinator that just migrates, but isn't used.
		// This will just handle the migration, without any configuration or else ...
		NSPersistentStore* tmpStore = [[self persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&err];
		// And remove it !
		[[self persistentStoreCoordinator] removePersistentStore:tmpStore error:&err];
	}
}

- (GVCDataSavedOperationBlock)defaultOperationDidSaveBlock
{
    return ^(GVCOperation *operation, NSNotification *notification) {
        [self mergeChanges:notification];
    };
}

- (void)mergeChanges:(NSNotification*)notification
{
	GVC_ASSERT([NSThread mainThread], @"Not on the main thread");
	
    if ([self managedObjectContext] != nil)
	{
		[[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    }
}

- (void)saveContext
{
    NSError *error = nil;
    if (([[self managedObjectContext] hasChanges] == YES) && ([[self managedObjectContext] save:&error] == NO))
    {
        GVC_ASSERT_LOG(@"Save failed: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

- (NSString *)description
{
	NSMutableString *buffer = [NSMutableString stringWithString:[super description]];
	[buffer appendFormat:@" stuff"];
	return buffer;
}

@end
