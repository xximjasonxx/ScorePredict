//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WeekRepository.h"
#import "GameRepository.h"
#import "PredictionRepository.h"

@interface RepositoryFactory : NSObject

@property (nonatomic, retain) WeekRepository *currentWeekRepository;
@property (nonatomic, retain) GameRepository *currentGameRepository;
@property (nonatomic, retain) PredictionRepository *currentPredictionRepository;

// class methods
+(RepositoryFactory *) getInstance;

// instance methods
-(WeekRepository *) getWeekRepository;
-(GameRepository *) getGameRepository;
-(PredictionRepository *) getPredictionRepository;

@end