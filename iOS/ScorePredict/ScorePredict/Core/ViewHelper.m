//
//  ViewHelper.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/23/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper
+(void)showWaitingView:(UIView *)view
{
    [DejalBezelActivityView activityViewForView:view].showNetworkActivityIndicator = YES;;
}

+(void)hideWaitingView
{
    [DejalBezelActivityView removeView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}

@end
