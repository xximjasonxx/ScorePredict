//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "Game.h"


@implementation Game

@synthesize gameId, gameDay, gameState, gameTime, awayTeam, homeTeam, awayTeamScore, homeTeamScore;
@synthesize weekNo, year, awayTeamAbbr, homeTeamAbbr;

- (NSString *)getGameState {
    if ([self.gameState.lowercaseString isEqualToString:@"p"]) {
        return @"Pregame";
    }

    if ([self.gameState.lowercaseString isEqualToString:@"f"]) {
        return @"Final";
    }

    return @"In Progress";
}

- (BOOL)isConcluded
{
    NSString *first = [[self getGameState] substringToIndex:1];
    return [first.lowercaseString isEqualToString:@"f"];
}

- (BOOL)inPregame
{
    NSString *first = [[self getGameState] substringToIndex:1];
    return [first.lowercaseString isEqualToString:@"p"];

}

@end