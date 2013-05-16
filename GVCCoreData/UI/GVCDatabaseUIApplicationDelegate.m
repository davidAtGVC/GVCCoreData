//
//  GVCDatabaseUIApplicationDelegate.m
//  GVCCoreData
//
//  Created by David Aspinall on 2013-05-15.
//
//

#import "GVCDatabaseUIApplicationDelegate.h"
#import "GVCXMLDataOperation.h"
#import "GVCCoreDatabase.h"

#import <GVCFoundation/GVCFoundation.h>


@implementation GVCDatabaseUIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL success = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if ( success == YES )
    {
		NSArray *modelPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"momd" inDirectory:nil];
		[modelPaths gvc_performOnEach:^(id item) {
			NSString *modelName = [[(NSString *)item lastPathComponent] stringByDeletingPathExtension];
			
			[GVCCoreDatabase databaseForModelName:modelName];
			
			// last pass, load any additional data files for each model
			NSArray *operations = [self modelLoadedOperations:modelName];
			[[self operationQueue] addOperations:operations waitUntilFinished:NO];
		}];
	}
	
    return success;
}

#pragma mark -
#pragma mark Core Data stack

- (NSArray *)modelLoadedOperations:(NSString *)modelName
{
    NSArray *arrayOfOperations = nil;
	GVCCoreDatabase *initialDatabase = [GVCCoreDatabase databaseForModelName:modelName];
    NSString *dataFile = GVC_SPRINTF(@"%@_initial_data", modelName);
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:dataFile ofType:@"xml"];
    GVCLogInfo( @"Looking for data named %@.xml", dataFile );
    if ( [[NSFileManager defaultManager] fileExistsAtPath:dataPath] == YES )
    {
        GVCLogInfo( @"  Found %@", dataPath );
        GVCXMLDataOperation *op = [[GVCXMLDataOperation alloc] initForPersistentStoreCoordinator:[initialDatabase persistentStoreCoordinator] usingFile:dataPath];
        arrayOfOperations = [NSArray arrayWithObject:op];
    }
    return arrayOfOperations;
}


#pragma mark - application lifecycle
- (void)applicationWillTerminate:(UIApplication *)application
{
	[super applicationWillTerminate:application];
	[[GVCCoreDatabase allDatabases] gvc_performOnEach:^(id item) {
		GVCCoreDatabase *database = (GVCCoreDatabase *)item;
		[database saveContext];
	}];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[super applicationDidEnterBackground:application];
	[[GVCCoreDatabase allDatabases] gvc_performOnEach:^(id item) {
		GVCCoreDatabase *database = (GVCCoreDatabase *)item;
		[database saveContext];
	}];
}

@end
