//
// Created by Jason Farrell on 12/28/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Prediction : NSObject
@property (nonatomic) int predictionId;
@property (nonatomic) int gameId;
@property (nonatomic) int predictedAwayScore;
@property (nonatomic) int predictedHomeScore;
@property (nonatomic) int pointsAwarded;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end