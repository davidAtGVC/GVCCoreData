// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Studio.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct StudioAttributes {
	__unsafe_unretained NSString *budget;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *studioID;
} StudioAttributes;

extern const struct StudioRelationships {
	__unsafe_unretained NSString *movies;
} StudioRelationships;

extern const struct StudioFetchedProperties {
} StudioFetchedProperties;

@class Movie;





@interface StudioID : NSManagedObjectID {}
@end

@interface _Studio : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (StudioID*)objectID;





@property (nonatomic, strong) NSDecimalNumber* budget;



//- (BOOL)validateBudget:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* studioID;



@property int64_t studioIDValue;
- (int64_t)studioIDValue;
- (void)setStudioIDValue:(int64_t)value_;

//- (BOOL)validateStudioID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *movies;

- (NSMutableSet*)moviesSet;





@end

@interface _Studio (CoreDataGeneratedAccessors)

- (void)addMovies:(NSSet*)value_;
- (void)removeMovies:(NSSet*)value_;
- (void)addMoviesObject:(Movie*)value_;
- (void)removeMoviesObject:(Movie*)value_;

@end

@interface _Studio (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveBudget;
- (void)setPrimitiveBudget:(NSDecimalNumber*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveStudioID;
- (void)setPrimitiveStudioID:(NSNumber*)value;

- (int64_t)primitiveStudioIDValue;
- (void)setPrimitiveStudioIDValue:(int64_t)value_;





- (NSMutableSet*)primitiveMovies;
- (void)setPrimitiveMovies:(NSMutableSet*)value;


@end
