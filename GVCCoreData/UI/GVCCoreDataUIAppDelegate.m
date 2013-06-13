/*
 * GVCCoreDataUIAppDelegate.m
 * 
 * Created by David Aspinall on 12-04-12. 
 * Copyright (c) 2012 Global Village Consulting. All rights reserved.
 *
 */

#import "GVCCoreDataUIAppDelegate.h"
#import <GVCFoundation/GVCFoundation.h>
#import "GVCXMLDataOperation.h"

@interface GVCCoreDataUIAppDelegate ()
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation GVCCoreDataUIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    BOOL success = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if ( success == YES )
    {
		NSArray *modelPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"momd" inDirectory:nil];
		NSMutableDictionary *allModels = [[NSMutableDictionary alloc] initWithCapacity:[modelPaths count]];
		
		// pass 1, collect and validate the modelss
		for ( NSString *momdPath in modelPaths )
		{
			NSString *modelName = [[momdPath lastPathComponent] stringByDeletingPathExtension];
			NSURL *modelURL = [NSURL fileURLWithPath:momdPath];
			NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

			NSMutableSet *entities = [NSMutableSet setWithArray:[model entitiesForConfiguration:modelName]];
			NSSet *modelset = [NSSet setWithArray:[model entities]];
			[entities minusSet:modelset];
			GVC_ASSERT(gvc_IsEmpty(entities), @"Configuration does not include all entities %@", entities);

			GVC_ASSERT([allModels objectForKey:modelName] == nil, @"Loaded duplicate model named %@", modelName);
			[allModels setObject:model forKey:modelName];
		}
		
		if ( [allModels count] > 0 )
		{
			[self initializeMergedModel:[allModels allValues]];
			
			for (NSString *modelName in [allModels allKeys])
			{
				// create one store sqlite file for each model
				// pass 2, install and migrate any seed data
				[self initializeSQLiteDatabase:modelName];
			}
			
			// last pass, load any additional data files for each model
			for (NSString *modelName in [allModels allKeys])
			{
				NSArray *operations = [self modelLoadedOperations:modelName];
				[[self operationQueue] addOperations:operations waitUntilFinished:NO];
			}
		}
	}
	
    return success;
}

- (void)initializeMergedModel:(NSArray *)allModels
{
	NSManagedObjectModel *superModel = [NSManagedObjectModel modelByMergingModels:allModels];
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:superModel];
	NSManagedObjectContext *moContext = [[NSManagedObjectContext alloc] init];
	[moContext setPersistentStoreCoordinator:coordinator];
	
	// TODO: check for database version and upgrade
	// maybe each model should have a version and a ModelUpgrade class
	// example [BucketsModel upgradeDatabase:moc];
	// [self upgradeDatabase];
	// [moContext setUndoManager:[[NSUndoManager  alloc] init]];
	[moContext setUndoManager:nil];
	
	// set the stack
	[self setManagedObjectModel:superModel];
	[self setPersistentStoreCoordinator:coordinator];
	[self setManagedObjectContext:moContext];
}

- (BOOL)purgeFailedMigrations
{
	return NO;
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

- (void)initializeSQLiteDatabase:(NSString *)modelName
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *err = nil;
	NSURL *storeURL = [[GVCDirectory DocumentDirectory] fullURLForFile:GVC_SPRINTF(@"%@.sqlite", modelName)];

	[self installSampleDatabase:modelName toURL:storeURL];
	
	if ([[self persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:modelName URL:storeURL options:nil error:&err] == nil)
	{
		GVCLogError( @"Failed to load sqlite %@", storeURL);

		// remove the datafile and try re-installing the sample
		if (([self purgeFailedMigrations] == YES) && ([fileManager removeItemAtURL:storeURL error:&err] == YES))
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

- (GVCDataSavedOperationBlock)defaultOperationDidSaveBlock
{
    return ^(GVCOperation *operation, NSNotification *notification) {
        [self mergeChanges:notification];
    };
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application
{
	[super applicationWillTerminate:application];
	[self saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[super applicationDidEnterBackground:application];
    [self saveContext];
}

#pragma mark -
#pragma mark Core Data stack

- (NSArray *)modelLoadedOperations:(NSString *)modelName
{
    NSArray *arrayOfOperations = nil;
    NSString *dataFile = GVC_SPRINTF(@"%@_initial_data", modelName);
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:dataFile ofType:@"xml"];
    GVCLogInfo( @"Looking for data named %@.xml", dataFile );
    if ( [[NSFileManager defaultManager] fileExistsAtPath:dataPath] == YES )
    {
        GVCLogInfo( @"  Found %@", dataPath );
        GVCXMLDataOperation *op = [[GVCXMLDataOperation alloc] initForPersistentStoreCoordinator:[self persistentStoreCoordinator] usingFile:dataPath];
        arrayOfOperations = [NSArray arrayWithObject:op];
    }
    return arrayOfOperations;
}

- (void)saveContext 
{
    NSError *error = nil;
    if (([[self managedObjectContext] hasChanges] == YES) && ([[self managedObjectContext] save:&error] == NO))
    {
        GVC_ASSERT_LOG(@"Save failed: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}


- (void)mergeChanges:(NSNotification*)notification
{
	GVC_ASSERT([NSThread mainThread], @"Not on the main thread");
	
    if ([self managedObjectContext] != nil) 
	{
		[[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    }
}


@end
