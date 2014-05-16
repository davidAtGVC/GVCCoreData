// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Talent.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct TalentAttributes {
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *talentID;
} TalentAttributes;

extern const struct TalentRelationships {
	__unsafe_unretained NSString *moviesDirected;
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *roles;
} TalentRelationships;

@class Movie;
@class TalentPhoto;
@class MovieRole;

@interface TalentID : NSManagedObjectID {}
@end

@interface _Talent : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TalentID*)objectID;

@property (nonatomic, strong) NSString* firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* talentID;

@property (atomic) int64_t talentIDValue;
- (int64_t)talentIDValue;
- (void)setTalentIDValue:(int64_t)value_;

//- (BOOL)validateTalentID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *moviesDirected;

- (NSMutableSet*)moviesDirectedSet;

@property (nonatomic, strong) TalentPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *roles;

- (NSMutableSet*)rolesSet;

@end

@interface _Talent (MoviesDirectedCoreDataGeneratedAccessors)
- (void)addMoviesDirected:(NSSet*)value_;
- (void)removeMoviesDirected:(NSSet*)value_;
- (void)addMoviesDirectedObject:(Movie*)value_;
- (void)removeMoviesDirectedObject:(Movie*)value_;
@end

@interface _Talent (RolesCoreDataGeneratedAccessors)
- (void)addRoles:(NSSet*)value_;
- (void)removeRoles:(NSSet*)value_;
- (void)addRolesObject:(MovieRole*)value_;
- (void)removeRolesObject:(MovieRole*)value_;
@end

@interface _Talent (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;

- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;

- (NSNumber*)primitiveTalentID;
- (void)setPrimitiveTalentID:(NSNumber*)value;

- (int64_t)primitiveTalentIDValue;
- (void)setPrimitiveTalentIDValue:(int64_t)value_;

- (NSMutableSet*)primitiveMoviesDirected;
- (void)setPrimitiveMoviesDirected:(NSMutableSet*)value;

- (TalentPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(TalentPhoto*)value;

- (NSMutableSet*)primitiveRoles;
- (void)setPrimitiveRoles:(NSMutableSet*)value;

@end
