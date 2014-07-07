//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "RepositoryFactory.h"
#import "WeekRepository.h"


@implementation RepositoryFactory

@synthesize currentGameRepository, currentWeekRepository, currentPredictionRepository;

+ (RepositoryFactory *)getInstance {
    static RepositoryFactory *currentFactory;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        currentFactory = [[self alloc] init];
    });

    return currentFactory;
}

// instance methods
-(WeekRepository *)getWeekRepository {
    if (self.currentWeekRepository == nil) {
        self.currentWeekRepository = [[WeekRepository alloc] init];
    }

    return self.currentWeekRepository;
}

-(GameRepository *)getGameRepository {
    if (self.currentGameRepository == nil) {
        self.currentGameRepository = [[GameRepository alloc] init];
    }

    return self.currentGameRepository;
}

-(PredictionRepository *)getPredictionRepository {
    if (self.currentPredictionRepository == nil) {
        self.currentPredictionRepository = [[PredictionRepository alloc] init];
    }

    return self.currentPredictionRepository;
}

@end