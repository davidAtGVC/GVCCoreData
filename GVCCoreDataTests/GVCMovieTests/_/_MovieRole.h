// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MovieRole.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct MovieRoleAttributes {
	__unsafe_unretained NSString *movieID;
	__unsafe_unretained NSString *roleName;
	__unsafe_unretained NSString *talentID;
} MovieRoleAttributes;

extern const struct MovieRoleRelationships {
	__unsafe_unretained NSString *movie;
	__unsafe_unretained NSString *talent;
} MovieRoleRelationships;

@class Movie;
@class Talent;

@interface MovieRoleID : NSManagedObjectID {}
@end

@interface _MovieRole : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MovieRoleID*)objectID;

@property (nonatomic, strong) NSNumber* movieID;

@property (atomic) int64_t movieIDValue;
- (int64_t)movieIDValue;
- (void)setMovieIDValue:(int64_t)value_;

//- (BOOL)validateMovieID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* roleName;

//- (BOOL)validateRoleName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* talentID;

@property (atomic) int64_t talentIDValue;
- (int64_t)talentIDValue;
- (void)setTalentIDValue:(int64_t)value_;

//- (BOOL)validateTalentID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Movie *movie;

//- (BOOL)validateMovie:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Talent *talent;

//- (BOOL)validateTalent:(id*)value_ error:(NSError**)error_;

@end

@interface _MovieRole (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveMovieID;
- (void)setPrimitiveMovieID:(NSNumber*)value;

- (int64_t)primitiveMovieIDValue;
- (void)setPrimitiveMovieIDValue:(int64_t)value_;

- (NSString*)primitiveRoleName;
- (void)setPrimitiveRoleName:(NSString*)value;

- (NSNumber*)primitiveTalentID;
- (void)setPrimitiveTalentID:(NSNumber*)value;

- (int64_t)primitiveTalentIDValue;
- (void)setPrimitiveTalentIDValue:(int64_t)value_;

- (Movie*)primitiveMovie;
- (void)setPrimitiveMovie:(Movie*)value;

- (Talent*)primitiveTalent;
- (void)setPrimitiveTalent:(Talent*)value;

@end
