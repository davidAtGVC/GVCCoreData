//
//  GVCDatabaseUIApplicationDelegate.h
//  GVCCoreData
//
//  Created by David Aspinall on 2013-05-15.
//
//

#import <GVCUIKit/GVCUIKit.h>

@interface GVCDatabaseUIApplicationDelegate : GVCUIApplicationDelegate


- (NSArray *)modelLoadedOperations:(NSString *)modelName;

@end
