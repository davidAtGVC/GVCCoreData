/*
 * MovieRole_Tests.m
 * 
 * Created by David Aspinall on 2013-02-18. 
 * Copyright (c) 2013 __MyCompanyName__. All rights reserved.
 *
 */

#import <SenTestingKit/SenTestingKit.h>
#import <GVCFoundation/GVCFoundation.h>
#import <GVCCoreData/GVCCoreData.h>

#import "GVCMovieTestsModel.h"
#import "GVCCoreDataTests.h"

#pragma mark - Interface declaration
@interface MovieRole_Tests : GVCCoreDataTests

@end


#pragma mark - Test Case implementation
@implementation MovieRole_Tests

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
- (void)testMovieRoleCount
{
	GVCCoreDatabase *dbase = [self database];
	GVCLogError(@"Database %@", dbase);
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:[MovieRole entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(entity, @"Could not find entity 'MovieRole'");
	
	NSArray *all = [MovieRole gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(all, @"Failed to find MovieRole");
	STAssertFalse(gvc_IsEmpty(all), @"No MovieRole found");
	
	STAssertTrue([all count] == 453, @"Incorrect MovieRole count 453 != %d", [all count]);
}

- (void)testMovieRoleRelationship
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:[MovieRole entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(entity, @"Could not find entity 'MovieRole'");
	
	NSArray *all = [MovieRole gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(all, @"Failed to find MovieRole");
	STAssertFalse(gvc_IsEmpty(all), @"No MovieRole found");
	
	for (MovieRole *record in all)
	{
		STAssertTrue(([record movieID] == nil) || ([record movie] != nil), @"MovieRole (movieID %@) does not have Movie", [record movieID]);
		STAssertTrue(([record talentID] == nil) || ([record talent] != nil), @"MovieRole (talentId %@) does not have Talent", [record talentID]);
	}
}

@end
