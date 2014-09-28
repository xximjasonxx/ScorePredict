//
//  GamePredictionFinalTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "GamePredictionFinalTableViewController.h"

@implementation GamePredictionFinalTableViewController
@synthesize awayScore, awayTeam, homeScore, homeTeam;
@synthesize predAwayScore, predAwayTeam, predHomeScore, predHomeTeam;
@synthesize game, prediction, pointsAwarded;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // first section
    awayTeam.text = [game getAwayCity];
    awayScore.text = [NSString stringWithFormat:@"%d", game.awayTeamScore];
    homeTeam.text = [game getHomeCity];
    homeScore.text = [NSString stringWithFormat:@"%d", game.homeTeamScore];
    
    // second section
    predAwayTeam.text = [game getAwayCity];
    predAwayScore.text = [NSString stringWithFormat:@"%d", prediction.predictedAwayScore];
    predHomeTeam.text = [game getHomeCity];
    predHomeScore.text = [NSString stringWithFormat:@"%d", prediction.predictedHomeScore];
    
    // third section
    pointsAwarded.text = [NSString stringWithFormat:@"%d", prediction.pointsAwarded];
}

@end
