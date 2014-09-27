//
//  ScorePredictViewControllerBaseViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/26/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "ScorePredictViewControllerBaseViewController.h"

@interface ScorePredictViewControllerBaseViewController ()

@end

@implementation ScorePredictViewControllerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTheKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)dismissTheKeyboard
{
    [self.view endEditing:YES];
}

@end
