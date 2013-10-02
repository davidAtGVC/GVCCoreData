/*
 * GVCXMLDataOperation.h
 * 
 * Created by David Aspinall on 12-05-07. 
 * Copyright (c) 2012 Global Village Consulting. All rights reserved.
 *
 */

#import "GVCDataOperation.h"

GVC_DEFINE_EXTERN_STR( GVCDataOperationErrorDomain )

@interface GVCXMLDataOperation : GVCDataOperation

- (id)initForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator usingFile:(NSString *)file;

@property (strong, nonatomic) NSString *loadFile;

/**
 * if true then existing recrds will cause an error rather than an update
 * @returns insert only state, default is NO
 */
@property (assign, nonatomic) BOOL insertOnly;

@end
