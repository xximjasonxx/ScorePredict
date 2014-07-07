//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Week : NSObject

@property (nonatomic) int weekNumber;
@property (nonatomic) int year;

-(id) initWeek:(int)weekNo withYear:(int)year;
@end