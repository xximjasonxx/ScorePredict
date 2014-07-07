//
//  AboutNavigationController.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/2/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "AboutNavigationController.h"

@interface AboutNavigationController ()

@end

@implementation AboutNavigationController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UITabBarItem * tabtitle = [[UITabBarItem alloc] initWithTitle: @"About"
                                                                image: [UIImage imageNamed:@"about"]
                                                                  tag: 2];
        [self setTabBarItem: tabtitle];
    }
    
    return self;
}

@end
