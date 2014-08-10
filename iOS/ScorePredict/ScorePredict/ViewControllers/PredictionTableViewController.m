//
//  PredictionTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "PredictionTableViewController.h"
#import "ImageTableData.h"
#import "TableData.h"

#import "DataTableViewCell.h"
#import "ImageDataTableViewCell.h"
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
    
    [topSection addObject:[[ImageTableData alloc] initWithTableCell:@"ImageDataCell"
                                                          withLabel:selectedGame.awayTeamAbbr
                                                          withValue:[NSString stringWithFormat:@"%d", selectedGame.awayTeamScore]
                                                           andImage:[UIImage imageNamed:selectedGame.awayTeamAbbr]]];
    
    [topSection addObject:[[ImageTableData alloc] initWithTableCell:@"ImageDataCell"
                                                          withLabel:selectedGame.homeTeamAbbr
                                                          withValue:[NSString stringWithFormat:@"%d", selectedGame.homeTeamScore]
                                                           andImage:[UIImage imageNamed:selectedGame.homeTeamAbbr]]];
    [dataArray setObject:topSection forKey:@"Top"];
    
    NSMutableArray *bottomSection = [[NSMutableArray alloc] init];
    NSString *predictedAwayScore = @"";
    NSString *predictedHomeScore = @"";
    
    if (selectedPrediction != nil) {
        predictedAwayScore = [NSString stringWithFormat:@"%d", selectedPrediction.predictedAwayScore];
        predictedHomeScore = [NSString stringWithFormat:@"%d", selectedPrediction.predictedHomeScore];
    }
    
    [bottomSection addObject:[[TableData alloc] initWithTableCell:@"TextEntryCell"
                                                        withLabel:selectedGame.awayTeamAbbr
                                                         withVaue:predictedAwayScore]];
    
    [bottomSection addObject:[[TableData alloc] initWithTableCell:@"TextEntryCell"
                                                        withLabel:selectedGame.homeTeamAbbr
                                                         withVaue:predictedHomeScore]];
    
    [dataArray setObject:bottomSection forKey:@"Bottom"];
}

-(void)buildFinalList
{
    NSMutableArray *topSection = [[NSMutableArray alloc] init];
    
    [topSection addObject:[[ImageTableData alloc] initWithTableCell:@"ImageDataCell"
                                                         withLabel:selectedGame.awayTeamAbbr
                                                         withValue:[NSString stringWithFormat:@"%d", selectedGame.awayTeamScore]
                                                          andImage:[UIImage imageNamed:selectedGame.awayTeamAbbr]]];
    
    [topSection addObject:[[ImageTableData alloc] initWithTableCell:@"ImageDataCell"
                                                         withLabel:selectedGame.homeTeamAbbr
                                                         withValue:[NSString stringWithFormat:@"%d", selectedGame.homeTeamScore]
                                                          andImage:[UIImage imageNamed:selectedGame.homeTeamAbbr]]];
    
    [dataArray setObject:topSection forKey:@"Top"];
    
    NSMutableArray *bottomSection = [[NSMutableArray alloc] init];
    if (selectedPrediction != nil) {
        [bottomSection addObject:[[ImageTableData alloc] initWithTableCell:@"ImageDataCell"
                                                                 withLabel:selectedGame.awayTeamAbbr
                                                                 withValue:[NSString stringWithFormat:@"%d", selectedPrediction.predictedAwayScore]
                                                                  andImage:[UIImage imageNamed:selectedGame.awayTeamAbbr]]];
        
        [bottomSection addObject:[[ImageTableData alloc] initWithTableCell:@"ImageDataCell"
                                                                 withLabel:selectedGame.awayTeamAbbr
                                                                 withValue:[NSString stringWithFormat:@"%d", selectedPrediction.predictedHomeScore]
                                                                  andImage:[UIImage imageNamed:selectedGame.homeTeamAbbr]]];
        
        [bottomSection addObject:[[TableData alloc] initWithTableCell:@"DataCell"
                                                            withLabel:@"Points Awarded"
                                                             withVaue:[NSString stringWithFormat:@"%d", selectedPrediction.pointsAwarded]]];
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
    return 2;
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
    if (section == 0) {
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
    
    if ([tableData.tableCell isEqual: @"ImageDataCell"]) {
        ImageDataTableViewCell *theCell = (ImageDataTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableData.tableCell];
        [theCell.imageView setImage:((ImageTableData *)tableData).image];
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
