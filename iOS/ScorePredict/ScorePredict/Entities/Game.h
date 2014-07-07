//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Game : NSObject
@property (nonatomic) int gameId;
@property (strong, nonatomic) NSString *gameDay;
@property (strong, nonatomic) NSString *gameTime;
@property (strong, nonatomic) NSString *gameState;
@property (strong, nonatomic) NSString *awayTeam;
@property (nonatomic) int awayTeamScore;
@property (strong, nonatomic) NSString *homeTeam;
@property (nonatomic) int homeTeamScore;
@property (nonatomic) int weekNo;
@property (nonatomic) int year;
@property (strong, nonatomic) NSString *awayTeamAbbr;
@property (strong, nonatomic) NSString *homeTeamAbbr;

- (NSString *) getGameState;
- (BOOL) isConcluded;
- (BOOL) inPregame;

@end