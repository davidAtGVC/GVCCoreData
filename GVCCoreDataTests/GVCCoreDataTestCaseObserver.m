/*
 * GVCCoreDataTestCaseObserver.m
 * 
 * Created by David Aspinall on 2013-09-30. 
 * Copyright (c) 2013 Global Village. All rights reserved.
 *
 */

#import <XCTest/XCTest.h>

#pragma mark - Interface declaration
@interface GVCCoreDataTestCaseObserver : XCTestLog

@end

static id mainSuite = nil;
extern void __gcov_flush(void);

#pragma mark - Test Case implementation
@implementation GVCCoreDataTestCaseObserver

+ (void)initialize
{
    [[NSUserDefaults standardUserDefaults] setValue:@"GVCCoreDataTestCaseObserver" forKey:XCTestObserverClassKey];
    [super initialize];
}

	// setup for all the following tests
- (void) testSuiteDidStart:(XCTestRun *) testRun;
{
    [super testSuiteDidStart:testRun];
    
    if (mainSuite == nil)
    {
        mainSuite = testRun;
    }
}

- (void)testSuiteDidStop:(XCTestRun *)testRun
{
    [super testSuiteDidStop:testRun];

#ifdef TEST_GCOVR
    if (mainSuite == testRun)
    {
        __gcov_flush();
    }
#endif
}

@end
