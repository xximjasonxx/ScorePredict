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

@implementation PredictionHistoryService

-(void)getPredictionYears:(id<GetPredictionYearsProtocol>)delegate
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
                       
                       [historyArray addObject:entry];
                   }
                   
                   [delegate predictionYearsRetrieved:historyArray];
               }
               else {
                   [delegate retrievalFailed];
               }
           }];
}

@end
