//
//  GamePredictionFinalTableViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Game.h"
#import "Prediction.h"

@interface GamePredictionFinalTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *awayTeam;
@property (weak, nonatomic) IBOutlet UILabel *awayScore;
@property (weak, nonatomic) IBOutlet UILabel *homeTeam;
@property (weak, nonatomic) IBOutlet UILabel *homeScore;
@property (weak, nonatomic) IBOutlet UILabel *predAwayTeam;
@property (weak, nonatomic) IBOutlet UILabel *predAwayScore;
@property (weak, nonatomic) IBOutlet UILabel *predHomeTeam;
@property (weak, nonatomic) IBOutlet UILabel *predHomeScore;
@property (weak, nonatomic) IBOutlet UILabel *pointsAwarded;

@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) Prediction *prediction;
@end
