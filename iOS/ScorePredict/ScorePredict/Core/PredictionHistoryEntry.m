//
//  PredictionHistoryEntry.m
//  ScorePredict
//
//  Created by Jason Farrell on 7/6/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "PredictionHistoryEntry.h"

@implementation PredictionHistoryEntry
@synthesize year, weeks;

-(id)init
{
    if (self = [super init]) {
        weeks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
