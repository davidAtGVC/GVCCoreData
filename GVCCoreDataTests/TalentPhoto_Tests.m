/*
 * TalentPhoto_Tests.m
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
@interface TalentPhoto_Tests : GVCCoreDataTests

@end


#pragma mark - Test Case implementation
@implementation TalentPhoto_Tests

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
- (void)testTalentPhotoCount
{
	GVCCoreDatabase *dbase = [self database];
	GVCLogError(@"Database %@", dbase);
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:[TalentPhoto entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(entity, @"Could not find entity 'TalentPhoto'");
	
	NSArray *all = [TalentPhoto gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(all, @"Failed to find TalentPhoto");
	STAssertFalse(gvc_IsEmpty(all), @"No TalentPhoto found");
	
	STAssertTrue([all count] == 461, @"Incorrect TalentPhoto count 461 != %d", [all count]);
}

- (void)testTalentPhotoRelationship
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:[TalentPhoto entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(entity, @"Could not find entity 'TalentPhoto'");
	
	NSArray *all = [TalentPhoto gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(all, @"Failed to find TalentPhoto");
	STAssertFalse(gvc_IsEmpty(all), @"No TalentPhoto found");

	for (TalentPhoto *record in all)
	{
		STAssertTrue(([record talentID] == nil) || ([record talent] != nil), @"TalentPhoto (talentId %@) does not have Talent", [record talentID]);
	}
}

@end
