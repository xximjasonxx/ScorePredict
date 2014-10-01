//
//  CurrentWeekService.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/25/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CurrentWeekProtocol.h"

@interface CurrentWeekService : NSObject
@property (nonatomic, weak) id <CurrentWeekProtocol> delegate;

- (id) initWithDelegate:(id<CurrentWeekProtocol>)delegate;
- (void)loadCurrentWeekFor:(NSString *)user withToken:(NSString *)token;
- (void)loadCurrentWeekFromRemoteFor:(NSString *)userId withToken:(NSString *)token;

@end
