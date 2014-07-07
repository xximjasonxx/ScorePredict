//
// Created by Jason Farrell on 12/28/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "Prediction.h"


@implementation Prediction
@synthesize predictionId, gameId, predictedAwayScore, predictedHomeScore, pointsAwarded;

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        predictionId = [(NSString *)[dictionary valueForKey:@"id"] integerValue];
        gameId = [(NSString *)[dictionary valueForKey:@"gameId"] integerValue];
        predictedAwayScore = [(NSString *)[dictionary valueForKey:@"awayTeamScore"] integerValue];
        predictedHomeScore = [(NSString *)[dictionary valueForKey:@"homeTeamScore"] integerValue];
    }
    
    return self;
}

@end