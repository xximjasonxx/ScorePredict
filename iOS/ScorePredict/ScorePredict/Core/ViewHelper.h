//
//  ViewHelper.h
//  ScorePredict
//
//  Created by Jason Farrell on 9/23/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DejalActivityView.h"

@interface ViewHelper : NSObject

+(void) showWaitingView:(UIView *)view;
+(void) hideWaitingView;

@end
