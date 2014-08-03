//
//  CurrentWeekTableViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/25/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CurrentWeekProtocol.h"

@interface CurrentWeekTableViewController : UITableViewController <CurrentWeekProtocol>
@property (nonatomic, strong) NSMutableDictionary *games;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuItem;

@end
