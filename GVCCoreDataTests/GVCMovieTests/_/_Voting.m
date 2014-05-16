// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Voting.m instead.

#import "_Voting.h"

const struct VotingAttributes VotingAttributes = {
	.movieID = @"movieID",
	.numberOfVotes = @"numberOfVotes",
	.runningAverage = @"runningAverage",
};

const struct VotingRelationships VotingRelationships = {
	.movie = @"movie",
};

@implementation VotingID
@end

@implementation _Voting

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Voting" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Voting";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Voting" inManagedObjectContext:moc_];
}

- (VotingID*)objectID {
	return (VotingID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"movieIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"movieID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numberOfVotesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numberOfVotes"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"runningAverageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"runningAverage"];
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
	[self setMovieID:@(value_)];
}

- (int64_t)primitiveMovieIDValue {
	NSNumber *result = [self primitiveMovieID];
	return [result longLongValue];
}

- (void)setPrimitiveMovieIDValue:(int64_t)value_ {
	[self setPrimitiveMovieID:@(value_)];
}

@dynamic numberOfVotes;

- (int64_t)numberOfVotesValue {
	NSNumber *result = [self numberOfVotes];
	return [result longLongValue];
}

- (void)setNumberOfVotesValue:(int64_t)value_ {
	[self setNumberOfVotes:@(value_)];
}

- (int64_t)primitiveNumberOfVotesValue {
	NSNumber *result = [self primitiveNumberOfVotes];
	return [result longLongValue];
}

- (void)setPrimitiveNumberOfVotesValue:(int64_t)value_ {
	[self setPrimitiveNumberOfVotes:@(value_)];
}

@dynamic runningAverage;

- (double)runningAverageValue {
	NSNumber *result = [self runningAverage];
	return [result doubleValue];
}

- (void)setRunningAverageValue:(double)value_ {
	[self setRunningAverage:@(value_)];
}

- (double)primitiveRunningAverageValue {
	NSNumber *result = [self primitiveRunningAverage];
	return [result doubleValue];
}

- (void)setPrimitiveRunningAverageValue:(double)value_ {
	[self setPrimitiveRunningAverage:@(value_)];
}

@dynamic movie;

@end

