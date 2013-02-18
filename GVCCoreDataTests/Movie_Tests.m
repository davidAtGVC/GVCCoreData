/*
 * Movie_Tests.m
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
@interface Movie_Tests : GVCCoreDataTests

@end


#pragma mark - Test Case implementation
@implementation Movie_Tests

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
- (void)testMovieCount
{
	NSEntityDescription *movieEntity = [NSEntityDescription entityForName:[Movie entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(movieEntity, @"Could not find entity 'Movie'");
	
	NSArray *allMovie = [Movie gvc_findAllObjects:movieEntity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(allMovie, @"Failed to find movies");
	STAssertFalse(gvc_IsEmpty(allMovie), @"No movies found");
	
	STAssertTrue([allMovie count] == 88, @"Incorrect movie count 88 != %d", [allMovie count]);
}

- (void)testStudioRelationship
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:[Movie entityName] inManagedObjectContext:[self managedObjectContext]];
	STAssertNotNil(entity, @"Could not find entity 'Movie'");
	
	NSArray *all = [Movie gvc_findAllObjects:entity forPredicate:nil inContext:[self managedObjectContext]];
	STAssertNotNil(all, @"Failed to find Movie");
	STAssertFalse(gvc_IsEmpty(all), @"No Movie found");
	
	NSEntityDescription *studioEntity = [NSEntityDescription entityForName:[Studio entityName] inManagedObjectContext:[self managedObjectContext]];
	for (Movie *record in all)
	{
		NSNumber *studioId = [record studioID];
		if ( studioId != nil )
		{
			NSManagedObject *studio = [NSManagedObject gvc_findObject:studioEntity forKey:StudioAttributes.studioID andValue:studioId inContext:[self managedObjectContext]];

			if ( studio != nil )
			{
				STAssertTrue((studio == nil) || ([record studio] != nil), @"Movie (studioID %@) does not have Studio", [record movieID]);
			}
			else
			{
				GVCLogError(@"Bad Movie Data %@ references no existant studio", record);
			}
		}
	}
}


@end
