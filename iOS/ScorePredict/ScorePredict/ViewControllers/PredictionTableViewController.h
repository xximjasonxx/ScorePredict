//
//  PredictionTableViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Game.h"
#import "Prediction.h"

@interface PredictionTableViewController : UITableViewController
@property(nonatomic, strong) Game *selectedGame;
@property(nonatomic, strong) Prediction *selectedPrediction;

@end
