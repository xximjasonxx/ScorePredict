//
//  MenuTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/20/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "MenuTableViewController.h"

@implementation MenuTableViewController
@synthesize menuItems;

UIColor *backgroundColor;

-(void)viewDidLoad
{
    backgroundColor = [UIColor colorWithRed:0x03/255.0 green:0x4e/255.0 blue:0x00 alpha:1.0f];
    
    self.view.backgroundColor = backgroundColor;
    self.tableView.backgroundColor = backgroundColor;
    self.tableView.separatorColor = backgroundColor;
    
    self.menuItems = @[@"title", @"current_week", @"history", @"about", @"logout"];
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setSeparatorColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = backgroundColor;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row != 0;
}

@end
