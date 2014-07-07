//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Week.h"

@interface WeekRepository : NSObject
@property (nonatomic, retain) NSMutableArray *weekArray;

-(void) addWeek:(Week *)week;
-(Week *)getCurrentWeek;

@end