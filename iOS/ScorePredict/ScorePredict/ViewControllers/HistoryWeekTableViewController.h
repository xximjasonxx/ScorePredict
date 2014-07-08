//
//  HistoryWeekTableViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/7/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PredictionHistoryEntry.h"

@interface HistoryWeekTableViewController : UITableViewController
@property (nonatomic, strong) PredictionHistoryEntry *historyEntry;

@end
