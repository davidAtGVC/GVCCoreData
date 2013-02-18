/*
 * GVCCoreDatabase.h
 * 
 * Created by David Aspinall on 2013-02-17. 
 * Copyright (c) 2013 __MyCompanyName__. All rights reserved.
 *
 */

#import <CoreData/CoreData.h>

#import "GVCDataOperation.h"

/**
 * Wrapper object for managing CoreData database
 */
@interface GVCCoreDatabase : NSObject

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;


/**
 * Finds or allocates the database for the specified model name
 * @returns the appropriate database
 */
+ (id)databaseForModelName:(NSString *)modelName purgeFailedMigrations:(BOOL)purge;


/**
 * Finds or allocates the database for the specified model name
 * @returns the appropriate database
 */
+ (id)databaseForModelName:(NSString *)modelName;

/**
 * Finds the approprate database object
 * @param entity - the entity description
 * @returns the appropriate database or nil
 */
+ (GVCCoreDatabase *)findDatabaseForEntity:(NSEntityDescription *)entity;

/**
 * Finds the approprate database object
 * @param entityName - the entity name
 * @returns the appropriate database or nil
 */
+ (GVCCoreDatabase *)findDatabaseForEntityName:(NSString *)entityName;

- (void)saveContext;
- (void)mergeChanges:(NSNotification*)notification;
- (GVCDataSavedOperationBlock)defaultOperationDidSaveBlock;

@end
