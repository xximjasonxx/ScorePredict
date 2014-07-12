//
//  HistoryGamesTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/11/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "HistoryGamesTableViewController.h"
#import "PredictionHistoryService.h"

@implementation HistoryGamesTableViewController
@synthesize weekNumber, year;

PredictionHistoryService *historyService;
NSArray *games;

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PredictionCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
