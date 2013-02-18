/*
 * GVCPlistDataOperation.h
 * 
 * Created by David Aspinall on 2013-02-17. 
 * Copyright (c) 2013 Global Village Consulting. All rights reserved.
 *
 */

#import "GVCDataOperation.h"

/**
 * This special marker in the plist denotes a null value.  "__NULL__"
 */
GVC_DEFINE_EXTERN_STR(GVCPlistDataOperation__NULL);

/**
 * This special marker in the plist denotes the array of attribute keys
 */
GVC_DEFINE_EXTERN_STR(GVCPlistDataOperation_attributeNames);

/**
 * This special marker in the plist denotes the array of rows
 */
GVC_DEFINE_EXTERN_STR(GVCPlistDataOperation_rows);

GVC_DEFINE_EXTERN_STR(GVCPlistDataOperation_relationships);
GVC_DEFINE_EXTERN_STR(GVCPlistDataOperation_relationshipName);
GVC_DEFINE_EXTERN_STR(GVCPlistDataOperation_sourceAttributes);
GVC_DEFINE_EXTERN_STR(GVCPlistDataOperation_destinationAttributes);

/**
 * This Operation is generally used to load data from a plist format.  The basic design assumptions are that the plist (in whatever format, follows the following data layout
 
 <plist version="1.0">
 <dict>
	<key>ENTITY_NAME</key>
	 <dict>
		<key>attributeNames</key>
		<array>
			<string>ATTRIBUTE</string>
			<string>ANNOTHER</string>
		</array>
		<key>rows</key>
		<array>
		 <array>
			 <string>VALUE</string>
			 <string>__NULL__</string>
		 </array>
		...

 */
@interface GVCPlistDataOperation : GVCDataOperation

- (id)initForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator usingFile:(NSString *)file;

@property (strong, nonatomic) NSString *loadFile;

@end
