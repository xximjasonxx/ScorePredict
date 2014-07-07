//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Prediction.h"

@interface PredictionRepository : NSObject
@property (nonatomic, retain) NSMutableDictionary *internalDictionary;

- (void)addPredictions:(NSArray *)predictions withWeek:(int)weekNo withYear:(int)year;

- (Prediction *)getPredictionForGame:(int)id;
- (void)addPrediction:(Prediction *)prediction withWeek:(int) weekNo withYear:(int) year;
- (void)updatePrediction:(Prediction *)prediction withWeek:(int)weekNo withYear:(int)year;
@end