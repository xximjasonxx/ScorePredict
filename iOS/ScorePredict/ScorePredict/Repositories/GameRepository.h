//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameRepository : NSObject
@property (nonatomic, retain) NSMutableDictionary *internalDictionary;

-(void)addGames:(NSArray *)games withWeek:(int)weekNo withYear:(int)year;
-(NSMutableDictionary *) getGamesForWeek:(int)weekNo withYear:(int)year;


@end