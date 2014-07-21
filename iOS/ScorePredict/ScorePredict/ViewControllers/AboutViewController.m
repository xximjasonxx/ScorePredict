//
//  AboutViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/24/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "AboutViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@implementation AboutViewController
@synthesize scrollView;

-(void)viewWillAppear:(BOOL)animated
{
    [scrollView setContentInset:UIEdgeInsetsZero];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"About";
    
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
