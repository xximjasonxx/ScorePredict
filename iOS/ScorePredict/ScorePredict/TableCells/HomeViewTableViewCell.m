//
//  HomeViewTableViewCell.m
//  ScorePredict
//
//  Created by Jason Farrell on 12/31/13.
//  Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "HomeViewTableViewCell.h"

@implementation HomeViewTableViewCell
@synthesize gameTime, gameState, awayScore, awayTeamImage, predictedAwayScore;
@synthesize homeScore, homeTeamImage, predictedHomeScore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
