//
//  PredictionSummaryTableViewCell.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/13/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PredictionSummaryTableViewCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *awayTeam;
@property (nonatomic, retain) IBOutlet UILabel *homeTeam;
@property (nonatomic, retain) IBOutlet UILabel *awayScore;
@property (nonatomic, retain) IBOutlet UILabel *homeScore;
@property (nonatomic, retain) IBOutlet UILabel *predictedAwayScore;
@property (nonatomic, retain) IBOutlet UILabel *predictedHomeScore;
@property (nonatomic, retain) IBOutlet UILabel *predictionPoints;

@end
