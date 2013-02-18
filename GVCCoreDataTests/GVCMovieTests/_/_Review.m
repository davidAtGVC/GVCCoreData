// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Review.m instead.

#import "_Review.h"

const struct ReviewAttributes ReviewAttributes = {
	.movieID = @"movieID",
	.review = @"review",
	.reviewer = @"reviewer",
};

const struct ReviewRelationships ReviewRelationships = {
	.movie = @"movie",
};

const struct ReviewFetchedProperties ReviewFetchedProperties = {
};

@implementation ReviewID
@end

@implementation _Review

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Review" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Review";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Review" inManagedObjectContext:moc_];
}

- (ReviewID*)objectID {
	return (ReviewID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"movieIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"movieID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic movieID;



- (int64_t)movieIDValue {
	NSNumber *result = [self movieID];
	return [result longLongValue];
}

- (void)setMovieIDValue:(int64_t)value_ {
	[self setMovieID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveMovieIDValue {
	NSNumber *result = [self primitiveMovieID];
	return [result longLongValue];
}

- (void)setPrimitiveMovieIDValue:(int64_t)value_ {
	[self setPrimitiveMovieID:[NSNumber numberWithLongLong:value_]];
}





@dynamic review;






@dynamic reviewer;






@dynamic movie;

	






@end
