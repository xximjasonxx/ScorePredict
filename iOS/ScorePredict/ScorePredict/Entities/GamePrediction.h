//
//  GamePrediction.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/12/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GamePrediction : NSObject
@property (nonatomic) int gameId;
@property (nonatomic, strong) NSString *gameDay;
@property (nonatomic, strong) NSString *gameTime;
@property (nonatomic, strong) NSString *gameState;
@property (nonatomic, strong) NSString *awayTeam;
@property (nonatomic, strong) NSString *homeTeam;
@property (nonatomic) int awayScore;
@property (nonatomic) int homeScore;
@property (nonatomic) int predictedAwayScore;
@property (nonatomic) int predictedHomeScore;
@property (nonatomic) int predictionPoints;

@end
