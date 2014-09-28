//
//  PredictionService.h
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PredictionService : NSObject

-(void)savePredictionFor:(int)game withAwayScore:(int)awayValue andHomeScore:(int)homeValue inWeek:(int)weekNo andInYear:(int)yearNo onComplete:(void (^)())completeHandler onError:(void (^)(NSString *))errorHandler;

@end
