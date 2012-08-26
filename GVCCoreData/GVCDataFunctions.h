/*
 *  DADataFunctions.h
 *
 *  Created by David Aspinall on 10-06-12.
 *  Copyright 2010 Global Village Consulting Inc. All rights reserved.
 *
 */

#ifndef _GVCCoreDataFunctions_
#define _GVCCoreDataFunctions_

#import <objc/objc.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSString.h>
#import <Foundation/NSValue.h>
#import <Foundation/NSDictionary.h>
#import <CoreData/CoreData.h>

#import "GVCFoundation.h"

GVC_EXTERN NSString *gvc_DefaultValueForProperty(NSPropertyDescription *property, NSString *contextOfUse);

/** this function returns a localized label for the specified property using the namespacing key following the following format
 * <pre>&lt;entityname&gt;_&lt;propertyname&gt;_&lt;context&gt;</pre>
 * and example might be
 * <pre>Transaction_name_placeholder</pre>
 */
GVC_EXTERN NSString *gvc_LocalizedPropertyLabelWithDefault(NSPropertyDescription *attribute, NSString *contextOfUse, NSString *defaultValue);

/**
 /** this function returns a localized label for the specified property using the namespacing key following the following format
 * <pre>&lt;entityname&gt;_&lt;propertyname&gt;_&lt;context&gt;</pre>
 * and example might be
 * <pre>Transaction_name_placeholder</pre>
 * The localized value will default to <pre>&lt;entityname&gt; &lt;propertyname&gt; &lt;context&gt;</pre> for attributes an example
 * <pre>Transaction_name_placeholder = "Transaction Name Placeholder";</pre>
 * for relationships <pre>'&lt;destination entityname&gt; &lt;context&gt;'</pre>
 * <pre>Account_transactions_label = "Transaction Label";</pre>
 * <pre>Account_transactions_add = "Transaction Add";</pre>
 */
GVC_EXTERN NSString *gvc_LocalizedPropertyLabelForContext(NSPropertyDescription *attribute, NSString *contextOfUse);

/** convenience function that set the context to "label" */
GVC_EXTERN NSString *gvc_LocalizedAttributeLabel(NSAttributeDescription *attribute);

/** convenience function that set the context to "placeholder" */
GVC_EXTERN NSString *gvc_LocalizedAttributePlaceholder(NSAttributeDescription *attribute);

/** convenience function that set the context to "label" */
GVC_EXTERN NSString *gvc_LocalizedRelationshipLabel(NSRelationshipDescription *relationship);

/** convenience function that set the context to "add" */
GVC_EXTERN NSString *gvc_LocalizedRelationshipAddLabel(NSRelationshipDescription *relationship);

#endif
