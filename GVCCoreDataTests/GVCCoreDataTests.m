//
//  GVCCoreDataTests.m
//  GVCCoreDataTests
//
//  Created by David Aspinall on 12-03-04.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "GVCCoreDataTests.h"

#pragma mark - Test Case implementation
@implementation GVCCoreDataTests

- (NSManagedObjectContext *)managedObjectContext
{
	return [[self database] managedObjectContext];
}

- (NSString *)pathForResource:(NSString *)name extension:(NSString *)ext
{
	XCTAssertNotNil(name, @"Resource name cannot be nil");
	
	NSString *file = [[NSBundle bundleForClass:[self class]] pathForResource:name ofType:ext];
	
	XCTAssertNotNil(file, @"Unable to locate %@.%@ file", name, ext);
	XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:file], @"File does not exist %@", file);
	
	return file;
}

- (void)processOperation:(GVCOperation *)op
{
	__block BOOL operationFinished = NO;
	
	[op setDidFinishBlock:^(GVCOperation *operation) {
		operationFinished = YES;
		GVCLogError(@"Finished %@", operation);
	}];
	[op setDidFailWithErrorBlock:^(GVCOperation *operation, NSError *operror) {
		operationFinished = YES;
		XCTAssertTrue(NO, @"Operation failed with error %@", operror);
	}];
	[[self queue] addOperation:op];
	[[self queue] waitUntilAllOperationsAreFinished];
	
	
    while (operationFinished == NO)
	{
		GVCLogError(@".. processing");
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1000]];
    }
}

// setup for all the following tests
- (void)setUp
{
    [super setUp];
	
	NSString *modelName = @"GVCMovieTests";
	[self setQueue:[[NSOperationQueue alloc] init]];
	
	static dispatch_once_t sharedDispatch;
	dispatch_once(&sharedDispatch, ^{
				
		// delete the datafile from previous tests
		NSString *modelSQL = [[GVCDirectory DocumentDirectory] fullpathForFile:GVC_SPRINTF(@"%@.sqlite", modelName)];
		GVCLogError(@"Deleting Old store %@", modelSQL);
		if ( [[NSFileManager defaultManager] fileExistsAtPath:modelSQL] == YES )
		{
			XCTAssertTrue([[NSFileManager defaultManager] removeItemAtPath:modelSQL error:nil], @"Failed to remove old file %@", modelSQL);
		}
	
		// everything is configured on the first call
		GVCCoreDatabase *initialDatabase = [GVCCoreDatabase databaseForModelName:modelName];
		
		NSString *dataPath = [self pathForResource:@"Movies" extension:@"plist"];
		XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:dataPath], @"Failed to find datafile 'Movies.plist'");
		if ( [[NSFileManager defaultManager] fileExistsAtPath:dataPath] == YES )
		{
			GVCLogError(@"Loading %@", dataPath);
			
			GVCPlistDataOperation *op = [[GVCPlistDataOperation alloc] initForPersistentStoreCoordinator:[initialDatabase persistentStoreCoordinator] usingFile:dataPath];
			
			[self processOperation:op];
		}
		GVCLogError(@"Loading complete");
	});
	
	[self setDatabase:[GVCCoreDatabase databaseForModelName:modelName]];
}

// tear down the test setup
- (void)tearDown
{
    [super tearDown];
}


@end
