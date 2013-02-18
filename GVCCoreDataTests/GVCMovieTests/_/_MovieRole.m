// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MovieRole.m instead.

#import "_MovieRole.h"

const struct MovieRoleAttributes MovieRoleAttributes = {
	.movieID = @"movieID",
	.roleName = @"roleName",
	.talentID = @"talentID",
};

const struct MovieRoleRelationships MovieRoleRelationships = {
	.movie = @"movie",
	.talent = @"talent",
};

const struct MovieRoleFetchedProperties MovieRoleFetchedProperties = {
};

@implementation MovieRoleID
@end

@implementation _MovieRole

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MovieRole" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MovieRole";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MovieRole" inManagedObjectContext:moc_];
}

- (MovieRoleID*)objectID {
	return (MovieRoleID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"movieIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"movieID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"talentIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"talentID"];
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





@dynamic roleName;






@dynamic talentID;



- (int64_t)talentIDValue {
	NSNumber *result = [self talentID];
	return [result longLongValue];
}

- (void)setTalentIDValue:(int64_t)value_ {
	[self setTalentID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveTalentIDValue {
	NSNumber *result = [self primitiveTalentID];
	return [result longLongValue];
}

- (void)setPrimitiveTalentIDValue:(int64_t)value_ {
	[self setPrimitiveTalentID:[NSNumber numberWithLongLong:value_]];
}





@dynamic movie;

	

@dynamic talent;

	






@end
