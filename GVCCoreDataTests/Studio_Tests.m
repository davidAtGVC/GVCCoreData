/*
 * Studio_Tests.m
 * 
 * Created by David Aspinall on 2013-02-18. 
 * Copyright (c) 2013 __MyCompanyName__. All rights reserved.
 *
 */

#import <XCTest/XCTest.h>
#import <GVCFoundation/GVCFoundation.h>
#import <GVCCoreData/GVCCoreData.h>

#import "GVCMovieTestsModel.h"
#import "GVCCoreDataTests.h"

#pragma mark - Interface declaration
@interface Studio_Tests : GVCCoreDataTests

@end


#pragma mark - Test Case implementation
@implementation Studio_Tests

// setup for all the following tests
- (void)setUp
{
    [super setUp];
}

// tear down the test setup
- (void)tearDown
{
    [super tearDown];
}

// All code under test must be linked into the Unit Test bundle
- (void)testStudioCount
{
	GVCCoreDatabase *dbase = [self database];
	GVCLogError(@"Database %@", dbase);
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:[Studio entityName] inManagedObjectContext:[self managedObjectContext]];
	XCTAssertNotNil(entity, @"Could not find entity 'Studio'");
	
	NSArray *all = [Studio gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	XCTAssertNotNil(all, @"Failed to find Studio");
	XCTAssertFalse(gvc_IsEmpty(all), @"No Studio found");
	
	XCTAssertTrue([all count] == 38, @"Incorrect Studio count 38 != %@", @([all count]));
}

//- (void)testStudioRelationship
//{
//	NSEntityDescription *entity = [NSEntityDescription entityForName:[Studio entityName] inManagedObjectContext:[self managedObjectContext]];
//	STAssertNotNil(entity, @"Could not find entity 'Studio'");
//	
//	NSArray *all = [Studio gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
//	STAssertNotNil(all, @"Failed to find Studio");
//	STAssertFalse(gvc_IsEmpty(all), @"No Studio found");
//	
//	for (Studio *record in all)
//	{
//	}
//}

@end
