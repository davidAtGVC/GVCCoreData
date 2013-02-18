// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlotSummary.m instead.

#import "_PlotSummary.h"

const struct PlotSummaryAttributes PlotSummaryAttributes = {
	.movieID = @"movieID",
	.summary = @"summary",
};

const struct PlotSummaryRelationships PlotSummaryRelationships = {
	.movie = @"movie",
};

const struct PlotSummaryFetchedProperties PlotSummaryFetchedProperties = {
};

@implementation PlotSummaryID
@end

@implementation _PlotSummary

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PlotSummary" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PlotSummary";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PlotSummary" inManagedObjectContext:moc_];
}

- (PlotSummaryID*)objectID {
	return (PlotSummaryID*)[super objectID];
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





@dynamic summary;






@dynamic movie;

	






@end
