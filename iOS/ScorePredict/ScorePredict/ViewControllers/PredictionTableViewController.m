//
//  PredictionTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "PredictionTableViewController.h"
#import "TableData.h"

#import "DataTableViewCell.h"
#import "TextEntryTableViewCell.h"

@implementation PredictionTableViewController
@synthesize selectedGame, selectedPrediction;

NSMutableDictionary *dataArray;

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [[NSMutableDictionary alloc] init];
    
    if ([selectedGame isConcluded]) {
        [self buildFinalList];
    }
    else if ([selectedGame inPregame]) {
        [self buildPregameList];
    }
    else {
        
    }
    
    [self.tableView reloadData];
}

-(void)buildPregameList
{
    NSMutableArray *topSection = [[NSMutableArray alloc] init];
    
    NSString *predictedAwayScore = @"";
    NSString *predictedHomeScore = @"";
    
    if (selectedPrediction != nil) {
        predictedAwayScore = [NSString stringWithFormat:@"%d", selectedPrediction.predictedAwayScore];
        predictedHomeScore = [NSString stringWithFormat:@"%d", selectedPrediction.predictedHomeScore];
    }
    
    [topSection addObject:[[TableData alloc] initWithTableCell:@"TextEntryCell"
                                                        withLabel:[selectedGame getAwayCity]
                                                         withVaue:predictedAwayScore]];
    
    [topSection addObject:[[TableData alloc] initWithTableCell:@"TextEntryCell"
                                                        withLabel:[selectedGame getHomeCity]
                                                         withVaue:predictedHomeScore]];
    
    [dataArray setObject:topSection forKey:@"Top"];
}

-(void)buildFinalList
{
    NSMutableArray *topSection = [[NSMutableArray alloc] init];
    
    [topSection addObject:[[TableData alloc] initWithTableCell:@"TeamDataCell"
                                                     withLabel:[selectedGame getAwayCity]
                                                      withVaue:[NSString stringWithFormat:@"%d", selectedGame.awayTeamScore]]];
    
    [topSection addObject:[[TableData alloc] initWithTableCell:@"TeamDataCell"
                                                     withLabel:[selectedGame getHomeCity]
                                                      withVaue:[NSString stringWithFormat:@"%d", selectedGame.homeTeamScore]]];

    
    [dataArray setObject:topSection forKey:@"Top"];
    
    NSMutableArray *bottomSection = [[NSMutableArray alloc] init];
    if (selectedPrediction != nil) {
        [bottomSection addObject:[[TableData alloc] initWithTableCell:@"DataCell"
                                                            withLabel:[selectedGame getAwayCity]
                                                             withVaue:[NSString stringWithFormat:@"%d", selectedPrediction.predictedAwayScore]]];
        
        [bottomSection addObject:[[TableData alloc] initWithTableCell:@"DataCell"
                                                            withLabel:[selectedGame getHomeCity]
                                                             withVaue:[NSString stringWithFormat:@"%d", selectedPrediction.predictedHomeScore]]];
    }
    else {
        [bottomSection addObject:[[TableData alloc] initWithTableCell:@"DataCell"
                                                            withLabel:@"No Prediction"
                                                             withVaue:@""]];
    }
    
    [dataArray setObject:bottomSection forKey:@"Bottom"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([selectedGame isConcluded])
        return 2;
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *keys = [dataArray allKeys];
    NSString *key = [keys objectAtIndex:section];
    int count = ((NSArray *)[dataArray objectForKey:key]).count;
    
    return count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0 && [selectedGame isConcluded]) {
        return @"Game";
    }
    else {
        return @"Prediction";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *keys = [dataArray allKeys];
    NSString *key = [keys objectAtIndex:indexPath.section];
    TableData *tableData = [[dataArray objectForKey:key] objectAtIndex:indexPath.row];
    
    if ([tableData.tableCell isEqual: @"TeamDataCell"]) {
        DataTableViewCell *theCell = (DataTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableData.tableCell];
        [theCell.label setText:tableData.label];
        
        if (tableData.value.length > 0) {
            [theCell.value setText:tableData.value];
        }
        
        return theCell;
    }
    
    if ([tableData.tableCell isEqual:@"TextEntryCell"]) {
        TextEntryTableViewCell *theCell = (TextEntryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableData.tableCell];
        [theCell.textLabel setText:tableData.label];
        [theCell.entryField setText:tableData.value];
        
        return theCell;
    }
    
    DataTableViewCell *theCell = (DataTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableData.tableCell];
    [theCell.label setText:tableData.label];
        
    if (tableData.value.length > 0) {
        [theCell.value setText:tableData.value];
    }
        
    return theCell;
}

@end
