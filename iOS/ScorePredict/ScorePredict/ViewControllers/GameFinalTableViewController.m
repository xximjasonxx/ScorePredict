//
//  GameFinalTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "GameFinalTableViewController.h"

@implementation GameFinalTableViewController
@synthesize awayTeam, awayScore, homeScore, homeTeam;
@synthesize game;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    awayTeam.text = [game getAwayCity];
    awayScore.text = [NSString stringWithFormat:@"%d", game.awayTeamScore];
    homeTeam.text = [game getHomeCity];
    homeScore.text = [NSString stringWithFormat:@"%d", game.homeTeamScore];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

@end
