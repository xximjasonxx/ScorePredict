//
//  HistoryGamesTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/11/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "HistoryGamesTableViewController.h"
#import "PredictionHistoryService.h"
#import "PredictionSummaryTableViewCell.h"
#import "GamePrediction.h"

@implementation HistoryGamesTableViewController
@synthesize weekNumber, year;

PredictionHistoryService *historyService;
NSArray *games;
int totalPoints;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"Week %d", weekNumber];
    totalPoints = 0;
    historyService = [[PredictionHistoryService alloc] init];
    [historyService getPredictionGameHistoryForWeekNumber:self.weekNumber andYear:self.year andDelegate:self];
}

-(void)retrievedGamesHistory:(NSArray *)predictionGames
{
    games = predictionGames;
    [self.tableView reloadData];
}

-(void)retrievalFailed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Failed to retrieve Game data"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    [alertView show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (games != nil) {
        return games.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PredictionSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PredictionCell" forIndexPath:indexPath];
    if (cell != nil) {
        GamePrediction *gamePrediction = (GamePrediction *)[games objectAtIndex:indexPath.row];
        
        [cell.awayTeam setImage:[UIImage imageNamed:[gamePrediction.awayTeam.lowercaseString stringByAppendingString:@".png"]]];
        [cell.homeTeam setImage:[UIImage imageNamed:[gamePrediction.homeTeam.lowercaseString stringByAppendingString:@".png"]]];
        [cell.awayScore setText:[NSString stringWithFormat:@"%d", gamePrediction.awayScore]];
        [cell.homeScore setText:[NSString stringWithFormat:@"%d", gamePrediction.homeScore]];
        [cell.predictedAwayScore setText:[NSString stringWithFormat:@"%d", gamePrediction.predictedAwayScore]];
        [cell.predictedHomeScore setText:[NSString stringWithFormat:@"%d", gamePrediction.predictedHomeScore]];
        [cell.predictionPoints setText:[NSString stringWithFormat:@"%d", gamePrediction.predictionPoints]];
        totalPoints += gamePrediction.predictionPoints;
    }
    
    return cell;
}

@end
