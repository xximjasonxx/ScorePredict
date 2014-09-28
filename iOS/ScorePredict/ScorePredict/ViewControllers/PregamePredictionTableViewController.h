//
//  PregamePredictionTableViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Game.h"
#import "Prediction.h"

@interface PregamePredictionTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *awayLabel;
@property (weak, nonatomic) IBOutlet UITextField *awayScore;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeScore;

@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) Prediction *prediction;

- (IBAction)save:(id)sender;

@end
