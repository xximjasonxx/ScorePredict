//
//  PredictionHistoryService.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/6/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GetPredictionDataProtocol.h"
#import "GetPredictionGamesHistoryProtocol.h"

@interface PredictionHistoryService : NSObject

-(void)getPredictionData:(id<GetPredictionDataProtocol>) delegate;
-(void)getPredictionGameHistoryForWeekNumber:(int)weekNumber andYear:(int)year andDelegate:(id<GetPredictionGamesHistoryProtocol>)delegate;

@end
