// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Voting.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct VotingAttributes {
	__unsafe_unretained NSString *movieID;
	__unsafe_unretained NSString *numberOfVotes;
	__unsafe_unretained NSString *runningAverage;
} VotingAttributes;

extern const struct VotingRelationships {
	__unsafe_unretained NSString *movie;
} VotingRelationships;

@class Movie;

@interface VotingID : NSManagedObjectID {}
@end

@interface _Voting : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (VotingID*)objectID;

@property (nonatomic, strong) NSNumber* movieID;

@property (atomic) int64_t movieIDValue;
- (int64_t)movieIDValue;
- (void)setMovieIDValue:(int64_t)value_;

//- (BOOL)validateMovieID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* numberOfVotes;

@property (atomic) int64_t numberOfVotesValue;
- (int64_t)numberOfVotesValue;
- (void)setNumberOfVotesValue:(int64_t)value_;

//- (BOOL)validateNumberOfVotes:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* runningAverage;

@property (atomic) double runningAverageValue;
- (double)runningAverageValue;
- (void)setRunningAverageValue:(double)value_;

//- (BOOL)validateRunningAverage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Movie *movie;

//- (BOOL)validateMovie:(id*)value_ error:(NSError**)error_;

@end

@interface _Voting (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveMovieID;
- (void)setPrimitiveMovieID:(NSNumber*)value;

- (int64_t)primitiveMovieIDValue;
- (void)setPrimitiveMovieIDValue:(int64_t)value_;

- (NSNumber*)primitiveNumberOfVotes;
- (void)setPrimitiveNumberOfVotes:(NSNumber*)value;

- (int64_t)primitiveNumberOfVotesValue;
- (void)setPrimitiveNumberOfVotesValue:(int64_t)value_;

- (NSNumber*)primitiveRunningAverage;
- (void)setPrimitiveRunningAverage:(NSNumber*)value;

- (double)primitiveRunningAverageValue;
- (void)setPrimitiveRunningAverageValue:(double)value_;

- (Movie*)primitiveMovie;
- (void)setPrimitiveMovie:(Movie*)value;

@end
