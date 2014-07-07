//
//  HistoryNavigationController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/24/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "HistoryNavigationController.h"

@implementation HistoryNavigationController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UITabBarItem * tabtitle = [[UITabBarItem alloc] initWithTitle: @"History"
                                                                image: [UIImage imageNamed:@"history"]
                                                                  tag: 1];
        [self setTabBarItem: tabtitle];
    }
    
    return self;
}

@end
