//
//  DADataOperation.h
//
//  Created by David Aspinall on 10-01-31.
//  Copyright 2012 Global Village Consulting Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <GVCFoundation/GVCFoundation.h>


typedef void (^GVCDataSavedOperationBlock)(GVCOperation *operation, NSNotification *notification);

@interface GVCDataOperation : GVCOperation

- initForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator;

// this block is always called from the main thread
@property (readwrite, copy) GVCDataSavedOperationBlock contextDidSaveBlock;

// subclasses should call initialize from the - main method.  This ensures the managedObjectContext is intialized in the correct thread
- (void)initializeCoreData;

/**
 * Saves the managed object context if the context has changes.  Calls operationDidFail and returns NO on failure
 * @returns success of save
 */
- (BOOL)saveContext;

@property (readonly, nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (NSEntityDescription *)entityForName:(NSString *)name;

@end
