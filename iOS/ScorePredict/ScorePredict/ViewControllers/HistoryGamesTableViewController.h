//
//  HistoryGamesTableViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/11/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetPredictionGamesHistoryProtocol.h"

@interface HistoryGamesTableViewController : UITableViewController<GetPredictionGamesHistoryProtocol>
@property (nonatomic) int weekNumber;
@property (nonatomic) int year;

@end
