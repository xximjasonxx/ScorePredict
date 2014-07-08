//
//  HistoryWeekTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/7/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "HistoryWeekTableViewController.h"

@implementation HistoryWeekTableViewController
@synthesize historyEntry;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Select Week";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (historyEntry != nil) {
        return historyEntry.weeks.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeekCell" forIndexPath:indexPath];
    NSNumber *weekNumber = [historyEntry.weeks objectAtIndex:indexPath.row];
    if (weekNumber != nil) {
        [cell.textLabel setText:[NSString stringWithFormat:@"Week %d", [weekNumber intValue]]];
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
