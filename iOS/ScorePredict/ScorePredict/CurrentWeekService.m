//
//  CurrentWeekService.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/25/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

#import "ClientFactory.h"
#import "RepositoryFactory.h"
#import "CurrentWeekService.h"
#import "Game.h"
#import "Prediction.h"
#import "CurrentWeekProtocol.h"

@implementation CurrentWeekService

- (id)initWithDelegate:(id<CurrentWeekProtocol>)delegate {
    if (self = [super init]) {
        // assign the delegate member
        self.delegate = delegate;
    }
    
    return self;
}

- (void)loadCurrentWeekFor:(NSString *)userId withToken:(NSString *)token {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    //[parameters setValue:[formatter stringFromDate:currentDate] forKey:@"weekForDate"];
    [parameters setValue:@"11/1/2013" forKey:@"weekForDate"];
    
    MSClient *client = [ClientFactory getClient];
    [client invokeAPI:@"weekFor"
                 body:nil
           HTTPMethod:@"GET"
           parameters:parameters
              headers:nil
           completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
               if (error == nil) {
                   // success
                   NSDictionary *resultDictionary = (NSDictionary *)result;
                   int weekNo = [((NSString *) [resultDictionary objectForKey:@"weekNo"]) integerValue];
                   int year = [((NSString *) [resultDictionary objectForKey:@"year"]) integerValue];
                   NSMutableArray *games = [self getGamesFrom:(NSArray *) [resultDictionary objectForKey:@"games"]];
                   NSMutableArray *predictions = [self getPredictionsFrom:(NSArray *) [resultDictionary objectForKey:@"predictions"]];
                   
                   RepositoryFactory *factory = [RepositoryFactory getInstance];
                   [[factory getWeekRepository] addWeek:[[Week alloc] initWeek:weekNo withYear:year]];
                   [[factory getGameRepository] addGames:games withWeek:weekNo withYear:year];
                   [[factory getPredictionRepository] addPredictions:predictions withWeek:weekNo withYear:year];
                   
                   [self.delegate currentWeekLoaded];
               }
               else {
                   [self.delegate loadFailed];
               }
           }];
}

- (NSMutableArray *) getGamesFrom:(NSArray *) games {
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:games.count];
    for (NSDictionary *d in games) {
        Game *game = [Game alloc];
        game.gameId = [((NSString *) [d objectForKey:@"gameId"]) integerValue];
        game.gameDay = (NSString *) [d objectForKey:@"gameDay"];
        game.gameTime = (NSString *) [d objectForKey:@"gameTime"];
        game.gameState = (NSString *) [d objectForKey:@"gameState"];
        game.awayTeam = (NSString *) [d objectForKey:@"awayTeam"];
        game.awayTeamScore = [(NSString *) [d objectForKey:@"awayScore"] integerValue];
        game.awayTeamAbbr = (NSString *) [d objectForKey:@"awayAbbr"];
        game.homeTeam = (NSString *) [d objectForKey:@"homeTeam"];
        game.homeTeamScore = [(NSString *) [d objectForKey:@"homeScore"] integerValue];
        game.homeTeamAbbr = (NSString *) [d objectForKey:@"homeAbbr"];
        game.weekNo = [(NSString *) [d objectForKey:@"weekNo"] integerValue];
        game.year = [(NSString *) [d objectForKey:@"year"] integerValue];
        
        [returnArray addObject:game];
    }
    
    return returnArray;
}

-(NSMutableArray *) getPredictionsFrom:(NSArray *) predictions {
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:predictions.count];
    for (NSDictionary *d in predictions) {
        Prediction *prediction = [Prediction alloc];
        prediction.predictionId = [(NSString *) [d objectForKey:@"id"] integerValue];
        prediction.gameId = [(NSString *) [d objectForKey:@"gameId"] integerValue];
        prediction.predictedAwayScore = [(NSString *) [d objectForKey:@"predictedAwayScore"] integerValue];
        prediction.predictedHomeScore = [(NSString *) [d objectForKey:@"predictedHomeScore"] integerValue];
        prediction.pointsAwarded = [(NSString *) [d objectForKey:@"pointsAwarded"] integerValue];
        
        [returnArray addObject:prediction];
    }
    
    return returnArray;
}

@end
