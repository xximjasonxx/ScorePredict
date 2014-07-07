//
//  CurrentWeekNavigationControllerViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/24/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "CurrentWeekNavigationControllerViewController.h"

@implementation CurrentWeekNavigationControllerViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UITabBarItem * tabtitle = [[UITabBarItem alloc] initWithTitle: @"Current"
                                                                image: [UIImage imageNamed:@"star"]
                                                                  tag: 0];
        
        [self setTabBarItem: tabtitle];
    }
    
    return self;
}

@end
