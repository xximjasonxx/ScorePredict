//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "Week.h"


@implementation Week
@synthesize weekNumber, year;

-(id)initWeek:(int)weekNo withYear:(int)yearVal {
    if (self = [super init]) {
        self.weekNumber = weekNo;
        self.year = yearVal;
    }

    return self;
}

@end