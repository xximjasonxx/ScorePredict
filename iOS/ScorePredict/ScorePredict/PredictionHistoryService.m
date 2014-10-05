//
//  PredictionHistoryService.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/6/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

#import "PredictionHistoryService.h"
#import "ClientFactory.h"
#import "PredictionHistoryEntry.h"
#import "GamePrediction.h"

@implementation PredictionHistoryService

-(void)getPredictionData:(id<GetPredictionDataProtocol>)delegate
{
    MSClient *client = [ClientFactory getClient];
    [client invokeAPI:@"prediction_history"
                 body:nil
           HTTPMethod:@"GET"
           parameters:nil
              headers:nil
           completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
               if (error == nil) {
                   NSMutableArray *historyArray = [[NSMutableArray alloc] init];
                   NSDictionary *resultDictionary = (NSDictionary *)result;
                   
                   for (NSString *key in resultDictionary) {
                       PredictionHistoryEntry *entry = [[PredictionHistoryEntry alloc] init];
                       entry.year = [key intValue];
                       
                       for (NSString *value in [resultDictionary objectForKey:key]) {
                           int weekNumber = [value intValue];
                           [entry.weeks addObject:[NSNumber numberWithInt:weekNumber]];
                       }
                       
                       [historyArray addObject:entry];
                   }
                   
                   [delegate predictionDataRetrieved:historyArray];
               }
               else {
                   [delegate retrievalFailed];
               }
           }];
}

-(void)getPredictionGameHistoryForWeekNumber:(int)weekNumber andYear:(int)year andDelegate:(id<GetPredictionGamesHistoryProtocol>)delegate
{
    MSClient *client = [ClientFactory getClient];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[NSString stringWithFormat:@"%d", year] forKey:@"year"];
    [parameters setValue:[NSString stringWithFormat:@"%d", weekNumber] forKey:@"weekNumber"];
    
    [client invokeAPI:@"prediction_games_history"
                 body:nil
           HTTPMethod:@"GET"
           parameters:parameters
              headers:nil
           completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
               if (error == nil) {
                   NSDictionary *resultDictionary = (NSDictionary *)result;
                   NSArray *predictions = (NSArray *)[resultDictionary objectForKey:@"predictions"];
                   NSMutableArray *returnArray = [[NSMutableArray alloc] init];
                   for (NSDictionary *prediction in predictions) {
                       GamePrediction *gamePrediction = [[GamePrediction alloc] init];
                       gamePrediction.gameId = [[prediction objectForKey:@"gameId"] integerValue];
                       gamePrediction.gameDay = [prediction objectForKey:@"gameDay"];
                       gamePrediction.gameTime = [prediction objectForKey:@"gameTime"];
                       gamePrediction.awayTeam = [prediction objectForKey:@"awayAbbr"];
                       gamePrediction.homeTeam = [prediction objectForKey:@"homeAbbr"];
                       gamePrediction.awayScore = [[prediction objectForKey:@"awayScore"] integerValue];
                       gamePrediction.homeScore = [[prediction objectForKey:@"homeScore"] integerValue];
                       gamePrediction.predictedAwayScore = [[prediction objectForKey:@"predictedAwayScore"] integerValue];
                       gamePrediction.predictedHomeScore = [[prediction objectForKey:@"predictedHomeScore"] integerValue];
                       gamePrediction.predictionPoints = [[prediction objectForKey:@"pointsAwarded"] integerValue];
                       
                       // dont need gamestate
                       
                       [returnArray addObject:gamePrediction];
                   }
                   
                   [delegate retrievedGamesHistory:returnArray];
               }
               else {
                   [delegate retrievalFailed];
               }
           }
     ];
}

@end
