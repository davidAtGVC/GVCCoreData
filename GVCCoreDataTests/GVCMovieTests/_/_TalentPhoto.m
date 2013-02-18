// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TalentPhoto.m instead.

#import "_TalentPhoto.h"

const struct TalentPhotoAttributes TalentPhotoAttributes = {
	.photo = @"photo",
	.talentID = @"talentID",
};

const struct TalentPhotoRelationships TalentPhotoRelationships = {
	.talent = @"talent",
};

const struct TalentPhotoFetchedProperties TalentPhotoFetchedProperties = {
};

@implementation TalentPhotoID
@end

@implementation _TalentPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TalentPhoto" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TalentPhoto";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TalentPhoto" inManagedObjectContext:moc_];
}

- (TalentPhotoID*)objectID {
	return (TalentPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"talentIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"talentID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic photo;






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





@dynamic talent;

	






@end
