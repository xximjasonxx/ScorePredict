//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "PredictionRepository.h"
#import "Prediction.h"


@implementation PredictionRepository
@synthesize internalDictionary;

- (id)init
{
    if (self = [super init]) {
        self.internalDictionary = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (void)addPredictions:(NSMutableArray *)predictions withWeek:(int)weekNo withYear:(int)year
{
    NSString *key = [self getKeyForWeek:weekNo andYear:year];
    [internalDictionary setValue:predictions forKey:key];
}

- (NSString *)getKeyForWeek:(int)weekNo andYear:(int)year
{
    return [NSString stringWithFormat:@"%02d%d", weekNo, year];
}

- (Prediction *)getPredictionForGame:(int)gameId {
    for (NSString *key in internalDictionary) {
        NSArray *predictions = (NSArray *) [internalDictionary objectForKey:key];
        for (Prediction *prediction in predictions) {
            if (prediction.gameId == gameId) {
                return prediction;
            }
        }
    }

    return nil;
}

- (void)addPrediction:(Prediction *)prediction withWeek:(int)weekNo withYear:(int)year
{
    NSString *key = [self getKeyForWeek:weekNo andYear:year];
    [[internalDictionary objectForKey:key] addObject:prediction];
}

- (void)updatePrediction:(Prediction *)prediction withWeek:(int)weekNo withYear:(int)year
{
    NSString *theKey = [self getKeyForWeek:weekNo andYear:year];
    for (Prediction *p in [self.internalDictionary valueForKey:theKey]) {
        if (p.predictionId == prediction.predictionId) {
            p.predictedAwayScore = prediction.predictedAwayScore;
            p.predictedHomeScore = prediction.predictedHomeScore;
            
            break;
        }
    }
}

@end