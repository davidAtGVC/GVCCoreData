//
//  GVCCoreDataTests.h
//  GVCCoreDataTests
//
//  Created by David Aspinall on 12-03-04.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <CoreData/CoreData.h>

#import <SenTestingKit/SenTestingKit.h>
#import <GVCFoundation/GVCFoundation.h>
#import <GVCCoreData/GVCCoreData.h>

#ifndef GVCCoreData_GVCCoreDataTest_h
#define GVCCoreData_GVCCoreDataTest_h

@interface GVCCoreDataTests : SenTestCase

@property (strong, nonatomic) GVCCoreDatabase *database;

- (NSManagedObjectContext *)managedObjectContext;

@property (strong, nonatomic) NSOperationQueue *queue;

- (NSString *)pathForResource:(NSString *)name extension:(NSString *)ext;

@end

#endif
