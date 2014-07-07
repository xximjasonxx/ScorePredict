//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "GameRepository.h"
#import "Game.h"

@implementation GameRepository
@synthesize internalDictionary;

-(id)init
{
    if (self = [super init]) {
        self.internalDictionary = [[NSMutableDictionary  alloc] init];
    }

    return self;
}

-(void)addGames:(NSMutableArray *)games withWeek:(int)weekNo withYear:(int)year
{
    NSString *key = [self getKeyForWeek:weekNo andYear:year];
    [self.internalDictionary setObject:games forKey:key];
}

-(NSMutableDictionary *)getGamesForWeek:(int)weekNo withYear:(int)year
{
    NSString *key = [self getKeyForWeek:weekNo andYear:year];
    NSArray *gameArray = [self.internalDictionary valueForKey:key];
    return [self getGamesByDay:gameArray];
}

-(NSString *)getKeyForWeek:(int)weekNo andYear:(int)year
{
    return [NSString stringWithFormat:@"%02d%d", weekNo, year];
}

-(NSMutableDictionary *) getGamesByDay:(NSArray *)games
{
    NSMutableDictionary *interim = [[NSMutableDictionary alloc] init];
    for (Game *game in games) {
        if ([interim objectForKey:game.gameDay] == nil) {
            [interim setValue:[[NSMutableArray alloc] init] forKey:game.gameDay];
        }

        [(NSMutableArray *) [interim objectForKey:game.gameDay] addObject:game];
    }

    NSArray *sortedKeys = [[interim allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *lhs, NSString *rhs) {
        NSArray *gameDays = [[NSArray alloc] initWithObjects:@"Thu", @"Fri", @"Sat", @"Sun", @"Mon", nil];
        NSInteger lhsIndex = [gameDays indexOfObject:lhs];
        NSInteger rhsIndex = [gameDays indexOfObject:rhs];

        if (lhsIndex > rhsIndex)
            return NSOrderedDescending;

        if (lhsIndex < rhsIndex)
            return NSOrderedAscending;

        return NSOrderedSame;
    }];

    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSString *key in sortedKeys) {
        [result setValue:[interim objectForKey:key] forKey:key];
    }

    return result;
}

@end