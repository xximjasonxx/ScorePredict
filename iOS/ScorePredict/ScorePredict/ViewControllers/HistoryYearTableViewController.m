//
//  HistoryYearTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/6/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "HistoryYearTableViewController.h"
#import "HistoryWeekTableViewController.h"
#import "PredictionHistoryService.h"
#import "PredictionHistoryEntry.h"
#import "UIViewController+ECSlidingViewController.h"

@implementation HistoryYearTableViewController

NSArray *predictionHistory;
PredictionHistoryService *historyService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Select Year";
    
    predictionHistory = [[NSArray alloc] init];
    
    historyService = [[PredictionHistoryService alloc] init];
    [historyService getPredictionData:self];
    
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

-(void)predictionDataRetrieved:(NSArray *)historyArray
{
    predictionHistory = historyArray;
    [self.tableView reloadData];
}

-(void)retrievalFailed
{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Failed to Get Prediction Years"
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
    
    [errorAlert show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (predictionHistory != nil)
        return 1;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (predictionHistory != nil)
        return predictionHistory.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YearCell" forIndexPath:indexPath];
    PredictionHistoryEntry *entry = [predictionHistory objectAtIndex:indexPath.row];
    
    if (entry != nil)
    {
        [[cell textLabel] setText:[NSString stringWithFormat:@"%d", entry.year]];
    }
    
    return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HistoryYearSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PredictionHistoryEntry *entry = [predictionHistory objectAtIndex:indexPath.row];
        HistoryWeekTableViewController *destViewController = segue.destinationViewController;
        
        destViewController.historyEntry = entry;
    }
}

@end
