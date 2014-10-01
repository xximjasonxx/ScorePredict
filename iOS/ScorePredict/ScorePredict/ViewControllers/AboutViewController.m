//
//  AboutViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/24/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "AboutViewController.h"
#import "SWRevealViewController.h"

@implementation AboutViewController
@synthesize menuButton;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"About";
    
    menuButton.target = self.revealViewController;
    menuButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

@end
