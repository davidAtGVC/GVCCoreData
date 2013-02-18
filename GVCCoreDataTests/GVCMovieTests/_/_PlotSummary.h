// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlotSummary.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct PlotSummaryAttributes {
	__unsafe_unretained NSString *movieID;
	__unsafe_unretained NSString *summary;
} PlotSummaryAttributes;

extern const struct PlotSummaryRelationships {
	__unsafe_unretained NSString *movie;
} PlotSummaryRelationships;

extern const struct PlotSummaryFetchedProperties {
} PlotSummaryFetchedProperties;

@class Movie;




@interface PlotSummaryID : NSManagedObjectID {}
@end

@interface _PlotSummary : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PlotSummaryID*)objectID;





@property (nonatomic, strong) NSNumber* movieID;



@property int64_t movieIDValue;
- (int64_t)movieIDValue;
- (void)setMovieIDValue:(int64_t)value_;

//- (BOOL)validateMovieID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* summary;



//- (BOOL)validateSummary:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Movie *movie;

//- (BOOL)validateMovie:(id*)value_ error:(NSError**)error_;





@end

@interface _PlotSummary (CoreDataGeneratedAccessors)

@end

@interface _PlotSummary (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveMovieID;
- (void)setPrimitiveMovieID:(NSNumber*)value;

- (int64_t)primitiveMovieIDValue;
- (void)setPrimitiveMovieIDValue:(int64_t)value_;




- (NSString*)primitiveSummary;
- (void)setPrimitiveSummary:(NSString*)value;





- (Movie*)primitiveMovie;
- (void)setPrimitiveMovie:(Movie*)value;


@end
