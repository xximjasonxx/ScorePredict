//
//  HistoryGamesTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/11/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "HistoryGamesTableViewController.h"

@implementation HistoryGamesTableViewController
@synthesize weekNumber, year;

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Information"
                                                       message:[NSString stringWithFormat:@"Week %d Year %d", self.weekNumber, self.year]
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
    
    [alertView show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
