//
//  PregamePredictionTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "PregamePredictionTableViewController.h"
#import "PredictionService.h"

@implementation PregamePredictionTableViewController
@synthesize awayLabel, awayScore, homeLabel, homeScore;
@synthesize game, prediction;

PredictionService *predictionService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*predictionService = [[PredictionService alloc] init];
    
    // set the game information
    awayLabel.text = [game getAwayCity];
    homeLabel.text = [game getHomeCity];
    
    if (prediction != nil)
    {
        awayScore.text = [NSString stringWithFormat:@"%d", prediction.predictedAwayScore];
        homeScore.text = [NSString stringWithFormat:@"%d", prediction.predictedHomeScore];
    }*/
}

- (IBAction)save:(id)sender {
}

@end
