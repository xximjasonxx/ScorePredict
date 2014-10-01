//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "WeekRepository.h"

@implementation WeekRepository
@synthesize weekArray;

-(id) init {
    if (self = [super init]) {
        self.weekArray = [[NSMutableArray alloc] init];
    }

    return self;
}

-(void)addWeek:(Week *)week {
    [self.weekArray addObject:week];
}

-(Week *)getCurrentWeek {
    if (self.weekArray.count == 0) {
        return nil;
    }

    if (self.weekArray.count == 1) {
        return weekArray[0];
    }

    // sort the week array first by year descending, and then by week number descending
    NSSortDescriptor *yearSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"year" ascending:NO];
    NSSortDescriptor *weekNoSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"weekNumber" ascending:NO];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:yearSortDescriptor, weekNoSortDescriptor, nil];
    NSArray *sortedArray = [self.weekArray sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray[0];
}

@end