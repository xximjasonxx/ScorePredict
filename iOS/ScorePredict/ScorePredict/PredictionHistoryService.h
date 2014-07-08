//
//  PredictionHistoryService.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/6/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GetPredictionYearsProtocol.h"

@interface PredictionHistoryService : NSObject

-(void)getPredictionYears:(id<GetPredictionYearsProtocol>) delegate;

@end
