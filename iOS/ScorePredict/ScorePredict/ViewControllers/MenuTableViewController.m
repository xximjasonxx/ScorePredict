//
//  MenuTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/20/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "MenuTableViewController.h"

@implementation MenuTableViewController
- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue { }

-(void)viewDidLoad
{
    // get the height of the screen
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;
    
    // set the background color of the view
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    // set the frame height
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,
                                 200, screenHeight);
}

@end
