/*
 * GVCCoreDataUIAppDelegate.m
 * 
 * Created by David Aspinall on 12-04-12. 
 * Copyright (c) 2012 Global Village Consulting. All rights reserved.
 *
 */

#import "GVCCoreDataUIAppDelegate.h"
#import "GVCFoundation.h"
#import "GVCXMLDataOperation.h"

@interface GVCCoreDataUIAppDelegate ()
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation GVCCoreDataUIAppDelegate

@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    BOOL success = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if ( success == YES )
    {
        // create a store for each model
        GVCLogInfo( @"application:(UIApplication *)application didFinishLaunchingWithOptions");
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *modelPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"momd" inDirectory:nil];
        NSMutableDictionary *allModels = [[NSMutableDictionary alloc] initWithCapacity:[modelPaths count]];
        
        for ( NSString *momdPath in modelPaths )
        {
            NSString *modelName = [[momdPath lastPathComponent] stringByDeletingPathExtension];
            NSURL *modelURL = [NSURL fileURLWithPath:momdPath];
            NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
            NSArray *hl7Entities = [model entitiesForConfiguration:modelName];
            GVC_ASSERT([[model entities] gvc_isEqualToArrayInAnyOrder:hl7Entities], @"Configuration for %@ does not include all entities", modelName);
            
            GVC_ASSERT([allModels objectForKey:modelName] == nil, @"Loaded duplicate model named %@", modelName);
            [allModels setObject:model forKey:modelName];
            
            // copy in sample data files if they exist
            NSString *modelSQL = [[GVCDirectory DocumentDirectory] fullpathForFile:GVC_SPRINTF(@"%@.sqlite", modelName)];
            if ( [fileManager fileExistsAtPath:modelSQL] == NO )
            {
                // copy in sample database 
                NSString *sample = [[NSBundle mainBundle] pathForResource:modelName ofType:@"sqlite"];
                if ( gvc_IsEmpty(sample) == NO )
                {
                    GVCLogInfo( @"Installing database %@", sample);
                    [fileManager copyItemAtPath:sample toPath:modelSQL error:nil];
                }
            }
            
            // force model to migrate now, does not work when models are combined
//            NSError *err = nil;
//            NSURL *storeURL = [NSURL fileURLWithPath:modelSQL];
//            NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
//            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
//            NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:modelName URL:storeURL options:options error:&err];
//            if (store == nil)
//            {
//                GVC_ASSERT(NO, @"Failed to allocate persistent/migrate store for %@.  Error %@ UserInfo %@", storeURL, [err localizedDescription], [err userInfo]);
//            }
        }
        
        if ( [allModels count] > 0 )
        {
            NSManagedObjectModel *superModel = [NSManagedObjectModel modelByMergingModels:[allModels allValues]];
            NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:superModel];
            NSManagedObjectContext *moContext = [[NSManagedObjectContext alloc] init];
            [moContext setPersistentStoreCoordinator:coordinator];
            
            // TODO: check for database version and upgrade
            // maybe each model should have a version and a ModelUpgrade class
            // example [BucketsModel upgradeDatabase:moc];
            // [self upgradeDatabase];
            [moContext setUndoManager:[[NSUndoManager  alloc] init]];
            
            // set the stack
            [self setManagedObjectModel:superModel];
            [self setPersistentStoreCoordinator:coordinator];
            [self setManagedObjectContext:moContext];
            
            // create one store sqlite file for each model
            
           // NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
            for (NSString *modelName in [allModels allKeys])
            {
                NSError *err = nil;
                NSURL *storeURL = [[GVCDirectory DocumentDirectory] fullURLForFile:GVC_SPRINTF(@"%@.sqlite", modelName)];
                if ([coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:modelName URL:storeURL options:nil error:&err] == nil)
                {
                    GVC_ASSERT(NO, @"Failed to allocate persistent store for %@.  Error %@", storeURL, [err description]);
                }
            }
            
            for (NSString *modelName in [allModels allKeys])
            {
                NSArray *operations = [self modelLoadedOperations:modelName];
                [[self operationQueue] addOperations:operations waitUntilFinished:NO];
            }
        }
    }

    return success;
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
	[self saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application 
{
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
