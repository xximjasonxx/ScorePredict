//
//  GetPredictionGamesHistoryProtocol.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/11/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetPredictionGamesHistoryProtocol <NSObject>

-(void)retrievedGamesHistory:(NSArray *) predictionGames;
-(void)retrievalFailed;

@end
