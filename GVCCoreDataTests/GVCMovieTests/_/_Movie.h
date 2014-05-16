// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Movie.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct MovieAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *dateReleased;
	__unsafe_unretained NSString *movieID;
	__unsafe_unretained NSString *posterName;
	__unsafe_unretained NSString *rated;
	__unsafe_unretained NSString *revenue;
	__unsafe_unretained NSString *studioID;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *trailerName;
} MovieAttributes;

extern const struct MovieRelationships {
	__unsafe_unretained NSString *directors;
	__unsafe_unretained NSString *plotSummary;
	__unsafe_unretained NSString *reviews;
	__unsafe_unretained NSString *roles;
	__unsafe_unretained NSString *studio;
	__unsafe_unretained NSString *voting;
} MovieRelationships;

@class Talent;
@class PlotSummary;
@class Review;
@class MovieRole;
@class Studio;
@class Voting;

@interface MovieID : NSManagedObjectID {}
@end

@interface _Movie : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MovieID*)objectID;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* dateReleased;

//- (BOOL)validateDateReleased:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* movieID;

@property (atomic) int64_t movieIDValue;
- (int64_t)movieIDValue;
- (void)setMovieIDValue:(int64_t)value_;

//- (BOOL)validateMovieID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* posterName;

//- (BOOL)validatePosterName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* rated;

//- (BOOL)validateRated:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDecimalNumber* revenue;

//- (BOOL)validateRevenue:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* studioID;

@property (atomic) int64_t studioIDValue;
- (int64_t)studioIDValue;
- (void)setStudioIDValue:(int64_t)value_;

//- (BOOL)validateStudioID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trailerName;

//- (BOOL)validateTrailerName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *directors;

- (NSMutableSet*)directorsSet;

@property (nonatomic, strong) PlotSummary *plotSummary;

//- (BOOL)validatePlotSummary:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *reviews;

- (NSMutableSet*)reviewsSet;

@property (nonatomic, strong) NSSet *roles;

- (NSMutableSet*)rolesSet;

@property (nonatomic, strong) Studio *studio;

//- (BOOL)validateStudio:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *voting;

- (NSMutableSet*)votingSet;

@end

@interface _Movie (DirectorsCoreDataGeneratedAccessors)
- (void)addDirectors:(NSSet*)value_;
- (void)removeDirectors:(NSSet*)value_;
- (void)addDirectorsObject:(Talent*)value_;
- (void)removeDirectorsObject:(Talent*)value_;
@end

@interface _Movie (ReviewsCoreDataGeneratedAccessors)
- (void)addReviews:(NSSet*)value_;
- (void)removeReviews:(NSSet*)value_;
- (void)addReviewsObject:(Review*)value_;
- (void)removeReviewsObject:(Review*)value_;
@end

@interface _Movie (RolesCoreDataGeneratedAccessors)
- (void)addRoles:(NSSet*)value_;
- (void)removeRoles:(NSSet*)value_;
- (void)addRolesObject:(MovieRole*)value_;
- (void)removeRolesObject:(MovieRole*)value_;
@end

@interface _Movie (VotingCoreDataGeneratedAccessors)
- (void)addVoting:(NSSet*)value_;
- (void)removeVoting:(NSSet*)value_;
- (void)addVotingObject:(Voting*)value_;
- (void)removeVotingObject:(Voting*)value_;
@end

@interface _Movie (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSDate*)primitiveDateReleased;
- (void)setPrimitiveDateReleased:(NSDate*)value;

- (NSNumber*)primitiveMovieID;
- (void)setPrimitiveMovieID:(NSNumber*)value;

- (int64_t)primitiveMovieIDValue;
- (void)setPrimitiveMovieIDValue:(int64_t)value_;

- (NSString*)primitivePosterName;
- (void)setPrimitivePosterName:(NSString*)value;

- (NSString*)primitiveRated;
- (void)setPrimitiveRated:(NSString*)value;

- (NSDecimalNumber*)primitiveRevenue;
- (void)setPrimitiveRevenue:(NSDecimalNumber*)value;

- (NSNumber*)primitiveStudioID;
- (void)setPrimitiveStudioID:(NSNumber*)value;

- (int64_t)primitiveStudioIDValue;
- (void)setPrimitiveStudioIDValue:(int64_t)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveTrailerName;
- (void)setPrimitiveTrailerName:(NSString*)value;

- (NSMutableSet*)primitiveDirectors;
- (void)setPrimitiveDirectors:(NSMutableSet*)value;

- (PlotSummary*)primitivePlotSummary;
- (void)setPrimitivePlotSummary:(PlotSummary*)value;

- (NSMutableSet*)primitiveReviews;
- (void)setPrimitiveReviews:(NSMutableSet*)value;

- (NSMutableSet*)primitiveRoles;
- (void)setPrimitiveRoles:(NSMutableSet*)value;

- (Studio*)primitiveStudio;
- (void)setPrimitiveStudio:(Studio*)value;

- (NSMutableSet*)primitiveVoting;
- (void)setPrimitiveVoting:(NSMutableSet*)value;

@end
