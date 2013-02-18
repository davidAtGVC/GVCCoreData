// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Studio.m instead.

#import "_Studio.h"

const struct StudioAttributes StudioAttributes = {
	.budget = @"budget",
	.name = @"name",
	.studioID = @"studioID",
};

const struct StudioRelationships StudioRelationships = {
	.movies = @"movies",
};

const struct StudioFetchedProperties StudioFetchedProperties = {
};

@implementation StudioID
@end

@implementation _Studio

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Studio" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Studio";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Studio" inManagedObjectContext:moc_];
}

- (StudioID*)objectID {
	return (StudioID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"studioIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"studioID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic budget;






@dynamic name;






@dynamic studioID;



- (int64_t)studioIDValue {
	NSNumber *result = [self studioID];
	return [result longLongValue];
}

- (void)setStudioIDValue:(int64_t)value_ {
	[self setStudioID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveStudioIDValue {
	NSNumber *result = [self primitiveStudioID];
	return [result longLongValue];
}

- (void)setPrimitiveStudioIDValue:(int64_t)value_ {
	[self setPrimitiveStudioID:[NSNumber numberWithLongLong:value_]];
}





@dynamic movies;

	
- (NSMutableSet*)moviesSet {
	[self willAccessValueForKey:@"movies"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"movies"];
  
	[self didAccessValueForKey:@"movies"];
	return result;
}
	






@end
