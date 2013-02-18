// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TalentPhoto.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct TalentPhotoAttributes {
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *talentID;
} TalentPhotoAttributes;

extern const struct TalentPhotoRelationships {
	__unsafe_unretained NSString *talent;
} TalentPhotoRelationships;

extern const struct TalentPhotoFetchedProperties {
} TalentPhotoFetchedProperties;

@class Talent;




@interface TalentPhotoID : NSManagedObjectID {}
@end

@interface _TalentPhoto : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TalentPhotoID*)objectID;





@property (nonatomic, strong) NSData* photo;



//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* talentID;



@property int64_t talentIDValue;
- (int64_t)talentIDValue;
- (void)setTalentIDValue:(int64_t)value_;

//- (BOOL)validateTalentID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Talent *talent;

//- (BOOL)validateTalent:(id*)value_ error:(NSError**)error_;





@end

@interface _TalentPhoto (CoreDataGeneratedAccessors)

@end

@interface _TalentPhoto (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitivePhoto;
- (void)setPrimitivePhoto:(NSData*)value;




- (NSNumber*)primitiveTalentID;
- (void)setPrimitiveTalentID:(NSNumber*)value;

- (int64_t)primitiveTalentIDValue;
- (void)setPrimitiveTalentIDValue:(int64_t)value_;





- (Talent*)primitiveTalent;
- (void)setPrimitiveTalent:(Talent*)value;


@end
