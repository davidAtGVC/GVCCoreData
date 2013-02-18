/*
 * Talent_Tests.m
 * 
 * Created by David Aspinall on 2013-02-17. 
 * Copyright (c) 2013 __MyCompanyName__. All rights reserved.
 *
 */

#import <SenTestingKit/SenTestingKit.h>
#import <GVCFoundation/GVCFoundation.h>
#import <GVCCoreData/GVCCoreData.h>

#import "GVCMovieTestsModel.h"
#import "GVCCoreDataTests.h"

#pragma mark - Interface declaration
@interface Talent_Tests : GVCCoreDataTests

@end


#pragma mark - Test Case implementation
@implementation Talent_Tests

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
- (void)testTalentCount
{
	GVCCoreDatabase *dbase = [self database];
	GVCLogError(@"Database %@", dbase);
	
	NSEntityDescription *talentEntity = [NSEntityDescription entityForName:[Talent entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(talentEntity, @"Could not find entity 'Talent'");
	
	NSArray *allTalent = [Talent gvc_findAllObjects:talentEntity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(allTalent, @"Failed to find Talents");
	STAssertFalse(gvc_IsEmpty(allTalent), @"No Talents found");
	
	STAssertTrue([allTalent count] == 462, @"Incorrect Talent count 462 != %d", [allTalent count]);
}

@end
