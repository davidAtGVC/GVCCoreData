/*
 * PlotSummary_Tests.m
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
@interface PlotSummary_Tests : GVCCoreDataTests

@end


#pragma mark - Test Case implementation
@implementation PlotSummary_Tests

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
- (void)testPlotSummaryCount
{
	GVCCoreDatabase *dbase = [self database];
	GVCLogError(@"Database %@", dbase);
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:[PlotSummary entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(entity, @"Could not find entity 'PlotSummary'");
	
	NSArray *all = [PlotSummary gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(all, @"Failed to find PlotSummary");
	STAssertFalse(gvc_IsEmpty(all), @"No PlotSummary found");
	
	STAssertTrue([all count] == 88, @"Incorrect PlotSummary count 88 != %d", [all count]);
}

- (void)testPlotSummaryRelationship
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:[PlotSummary entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(entity, @"Could not find entity 'PlotSummary'");
	
	NSArray *all = [PlotSummary gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(all, @"Failed to find PlotSummary");
	STAssertFalse(gvc_IsEmpty(all), @"No PlotSummary found");
	
	for (PlotSummary *record in all)
	{
		STAssertTrue(([record movieID] == nil) || ([record movie] != nil), @"PlotSummary (movieID %@) does not have Movie", [record movieID]);
	}
}

@end
