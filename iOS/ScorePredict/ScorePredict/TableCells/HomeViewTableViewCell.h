//
//  HomeViewTableViewCell.h
//  ScorePredict
//
//  Created by Jason Farrell on 12/31/13.
//  Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *gameTime;
@property (weak, nonatomic) IBOutlet UILabel *homeTeam;
@property (weak, nonatomic) IBOutlet UILabel *awayTeam;
@property (weak, nonatomic) IBOutlet UILabel *homeScore;
@property (weak, nonatomic) IBOutlet UILabel *awayScore;
@property (weak, nonatomic) IBOutlet UILabel *predictedHomeScore;
@property (weak, nonatomic) IBOutlet UILabel *predictedAwayScore;
@property (weak, nonatomic) IBOutlet UILabel *gameState;

@end
