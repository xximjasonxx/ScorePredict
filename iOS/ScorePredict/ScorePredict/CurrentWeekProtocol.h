//
//  CurrentWeekProtocol.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/25/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CurrentWeekProtocol <NSObject>

@required
-(void) currentWeekLoaded;
-(void) loadFailed;

@end

