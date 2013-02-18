// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Review.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct ReviewAttributes {
	__unsafe_unretained NSString *movieID;
	__unsafe_unretained NSString *review;
	__unsafe_unretained NSString *reviewer;
} ReviewAttributes;

extern const struct ReviewRelationships {
	__unsafe_unretained NSString *movie;
} ReviewRelationships;

extern const struct ReviewFetchedProperties {
} ReviewFetchedProperties;

@class Movie;





@interface ReviewID : NSManagedObjectID {}
@end

@interface _Review : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ReviewID*)objectID;





@property (nonatomic, strong) NSNumber* movieID;



@property int64_t movieIDValue;
- (int64_t)movieIDValue;
- (void)setMovieIDValue:(int64_t)value_;

//- (BOOL)validateMovieID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* review;



//- (BOOL)validateReview:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* reviewer;



//- (BOOL)validateReviewer:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Movie *movie;

//- (BOOL)validateMovie:(id*)value_ error:(NSError**)error_;





@end

@interface _Review (CoreDataGeneratedAccessors)

@end

@interface _Review (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveMovieID;
- (void)setPrimitiveMovieID:(NSNumber*)value;

- (int64_t)primitiveMovieIDValue;
- (void)setPrimitiveMovieIDValue:(int64_t)value_;




- (NSString*)primitiveReview;
- (void)setPrimitiveReview:(NSString*)value;




- (NSString*)primitiveReviewer;
- (void)setPrimitiveReviewer:(NSString*)value;





- (Movie*)primitiveMovie;
- (void)setPrimitiveMovie:(Movie*)value;


@end
