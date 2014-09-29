//
//  PredictionService.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "PredictionService.h"
#import "PredictionRepository.h"
#import "Prediction.h"
#import "ClientFactory.h"

@implementation PredictionService

PredictionRepository *predictionRepository;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        predictionRepository = [[PredictionRepository alloc] init];
    }
    
    return self;
}

-(void)savePredictionFor:(int)game withAwayScore:(int)awayValue andHomeScore:(int)homeValue inWeek:(int)weekNo andInYear:(int)yearNo onComplete:(void (^)())completeHandler onError:(void (^)(NSString *))errorHandler
{
    // attempt to find an existing prediction
    Prediction *thePrediction = [predictionRepository getPredictionForGame:game];
    if (thePrediction == nil)
    {
        [self createPredictionFor:game
                    withAwayScore:awayValue
                     andHomeScore:homeValue
                       onComplete:^(NSDictionary *data) {
                           Prediction *newPrediction = [[Prediction alloc] initWithDictionary:data];
                           [predictionRepository addPrediction:newPrediction withWeek:weekNo withYear:yearNo];
                           
                           completeHandler();
                       } onError:^(NSString *errorMessage) {
                           errorHandler(errorMessage);
                       }];
    }
    else
    {
        [self updatePredictionFor:game
                    withAwayScore:awayValue andHomeScore:homeValue
                           withId:thePrediction.predictionId
                       onComplete:^(NSDictionary *item) {
                           Prediction *existingPrediction = [[Prediction alloc] initWithDictionary:item];
                           [predictionRepository updatePrediction:existingPrediction withWeek:weekNo withYear:yearNo];
                           
                           completeHandler();
                       } onError:^(NSString *errorMessage) {
                           errorHandler(errorMessage);
                       }];
    }
}

// network methods
-(void)createPredictionFor:(int)gameId withAwayScore:(int)awayScore andHomeScore:(int)homeScore onComplete:(void (^)(NSDictionary *))completeHandler onError:(void (^)(NSString *))errorHandler
{
    MSTable *predictionsTable = [[ClientFactory getClient] tableWithName:@"predictions"];
    NSMutableDictionary *prediction = [[NSMutableDictionary alloc] init];
    
    [prediction setObject:[NSNumber numberWithInt:awayScore] forKey:@"awayTeamScore"];
    [prediction setObject:[NSNumber numberWithInt:gameId] forKey:@"gameId"];
    [prediction setObject:[NSNumber numberWithInt:homeScore] forKey:@"homeTeamScore"];
    
    [predictionsTable insert:prediction completion:^(NSDictionary *item, NSError *error) {
        if (error == nil)
        {
            completeHandler(item);
        }
        else
        {
            errorHandler(error.localizedDescription);
        }
    }];
}

-(void)updatePredictionFor:(int)gameId withAwayScore:(int)awayScore andHomeScore:(int)homeScore withId:(int)id onComplete:(void (^)(NSDictionary *))completeHandler onError:(void (^)(NSString *))errorHandler
{
    MSTable *predictionsTable = [[ClientFactory getClient] tableWithName:@"predictions"];
    NSMutableDictionary *prediction = [[NSMutableDictionary alloc] init];
    
    [prediction setObject:[NSNumber numberWithInt:awayScore] forKey:@"awayTeamScore"];
    [prediction setObject:[NSNumber numberWithInt:gameId] forKey:@"gameId"];
    [prediction setObject:[NSNumber numberWithInt:homeScore] forKey:@"homeTeamScore"];
    [prediction setObject:[NSNumber numberWithInt:id] forKey:@"id"];
    
    [predictionsTable update:prediction completion:^(NSDictionary *item, NSError *error) {
        if (error == nil)
        {
            completeHandler(item);
        }
        else
        {
            errorHandler(error.localizedDescription);
        }
    }];

}

@end
