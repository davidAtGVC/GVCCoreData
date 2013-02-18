/**
 * Header for GVCCoreData
 */

#ifndef GVCCoreData_h
#define GVCCoreData_h


/* 
 * Additions 
 */
#import "NSEntityDescription+GVCCoreData.h"
#import "NSManagedObject+GVCCoreData.h"
#import "NSManagedObjectContext+GVCCoreData.h"
#import "NSPropertyDescription+GVCCoreData.h"

/* 
 * 
 */
#import "GVCCoreDatabase.h"
#import "GVCDataFunctions.h"
#import "GVCManagedObject.h"

/* 
 * Operations 
 */
#import "GVCCSVDataOperation.h"
#import "GVCDataOperation.h"
#import "GVCPlistDataOperation.h"
#import "GVCXMLDataOperation.h"

/* 
 * UI 
 */
#import "GVCCoreDataUIAppDelegate.h"

/* 
 * UI viewcontroller 
 */
#import "GVCDataListTableViewController.h"
#import "GVCManagedObjectEditTableViewController.h"
#import "GVCManagedObjectTableViewController.h"
#import "GVCUIViewSearchableTableController.h"

#endif // GVCCoreData_h
