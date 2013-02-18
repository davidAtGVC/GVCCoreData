// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Movie.m instead.

#import "_Movie.h"

const struct MovieAttributes MovieAttributes = {
	.category = @"category",
	.dateReleased = @"dateReleased",
	.movieID = @"movieID",
	.posterName = @"posterName",
	.rated = @"rated",
	.revenue = @"revenue",
	.studioID = @"studioID",
	.title = @"title",
	.trailerName = @"trailerName",
};

const struct MovieRelationships MovieRelationships = {
	.directors = @"directors",
	.plotSummary = @"plotSummary",
	.reviews = @"reviews",
	.roles = @"roles",
	.studio = @"studio",
	.voting = @"voting",
};

const struct MovieFetchedProperties MovieFetchedProperties = {
};

@implementation MovieID
@end

@implementation _Movie

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Movie";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Movie" inManagedObjectContext:moc_];
}

- (MovieID*)objectID {
	return (MovieID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"movieIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"movieID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"studioIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"studioID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic category;






@dynamic dateReleased;






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





@dynamic posterName;






@dynamic rated;






@dynamic revenue;






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





@dynamic title;






@dynamic trailerName;






@dynamic directors;

	
- (NSMutableSet*)directorsSet {
	[self willAccessValueForKey:@"directors"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"directors"];
  
	[self didAccessValueForKey:@"directors"];
	return result;
}
	

@dynamic plotSummary;

	

@dynamic reviews;

	
- (NSMutableSet*)reviewsSet {
	[self willAccessValueForKey:@"reviews"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reviews"];
  
	[self didAccessValueForKey:@"reviews"];
	return result;
}
	

@dynamic roles;

	
- (NSMutableSet*)rolesSet {
	[self willAccessValueForKey:@"roles"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"roles"];
  
	[self didAccessValueForKey:@"roles"];
	return result;
}
	

@dynamic studio;

	

@dynamic voting;

	
- (NSMutableSet*)votingSet {
	[self willAccessValueForKey:@"voting"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"voting"];
  
	[self didAccessValueForKey:@"voting"];
	return result;
}
	






@end
