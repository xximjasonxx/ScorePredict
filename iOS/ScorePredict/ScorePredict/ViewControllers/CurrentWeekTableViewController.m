//
//  CurrentWeekTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/25/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "CurrentWeekTableViewController.h"
#import "PredictionTableViewController.h"

#import "HomeViewTableViewCell.h"
#import "RepositoryFactory.h"
#import "CurrentWeekService.h"
#import "Game.h"

@implementation CurrentWeekTableViewController
@synthesize games;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.games = [[NSMutableDictionary alloc] init];
    self.title = @"";
}

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"UserId"];
    NSString *token = [defaults objectForKey:@"Token"];
    
    CurrentWeekService *service = [[CurrentWeekService alloc] initWithDelegate:self];
    [service loadCurrentWeekFor:userId withToken:token];
}

-(void)currentWeekLoaded
{
    RepositoryFactory *factory = [RepositoryFactory getInstance];
    Week *currentWeek = [[factory getWeekRepository] getCurrentWeek];
    self.title = [NSString stringWithFormat:@"Week %d %d", currentWeek.weekNumber, currentWeek.year];
    
    [self.games addEntriesFromDictionary:[[factory getGameRepository] getGamesForWeek:currentWeek.weekNumber
                                                                             withYear:currentWeek.year]];
    if (self.games.count > 0) {
        [self.tableView reloadData];
    }
    else {
        self.title = @"No Games";
    }
}

-(void)loadFailed
{
    [self showAlertMessage:@"Failed to load data for the current week. Please refresh"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.games == nil)
        return 0;
    
    return self.games.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[self.games allKeys] objectAtIndex:section];
    NSArray *array = [self.games objectForKey:key];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GameCell";
    
    HomeViewTableViewCell *cell = (HomeViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HomeViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier];
    }
    
    Game *game = [self getGameForSection:indexPath.section andRow:indexPath.row];
    if (game != nil) {
        cell.awayScore.text = [NSString stringWithFormat:@"%d", game.awayTeamScore];
        cell.homeScore.text = [NSString stringWithFormat:@"%d", game.homeTeamScore];
        cell.gameTime.text = [game.gameTime stringByAppendingString:@"pm"];
        cell.gameState.text = [game getGameState];
        cell.awayTeamImage.image = [UIImage imageNamed:[game.awayTeamAbbr.lowercaseString stringByAppendingString:@".png"]];
        cell.homeTeamImage.image = [UIImage imageNamed:[game.homeTeamAbbr.lowercaseString stringByAppendingString:@".png"]];
        
        if ([game.gameState.lowercaseString isEqualToString:@"ip"]) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        // check for a prediction
        PredictionRepository *predictionRepo = [[RepositoryFactory getInstance] getPredictionRepository];
        [cell.predictedAwayScore setHidden:YES];
        [cell.predictedHomeScore setHidden:YES];
        
        Prediction *prediction = [predictionRepo getPredictionForGame:game.gameId];
        if (prediction != nil) {
            [cell.predictedAwayScore setHidden:NO];
            [cell.predictedHomeScore setHidden:NO];
            
            cell.predictedAwayScore.text = [NSString stringWithFormat:@"%d", prediction.predictedAwayScore];
            cell.predictedHomeScore.text = [NSString stringWithFormat:@"%d", prediction.predictedHomeScore];
        }
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.games allKeys] objectAtIndex:section];
}

-(void)showAlertMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Occured"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok:"
                                              otherButtonTitles:nil];
    
    [alertView show];
}

-(Game *)getGameForSection:(int)sectionIndex andRow:(int)rowIndex
{
    NSString *key = [[self.games allKeys] objectAtIndex:sectionIndex];
    return [[self.games objectForKey:key] objectAtIndex:rowIndex];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"PredictionView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Game *game = [self getGameForSection:indexPath.section andRow:indexPath.row];
        if (game == nil) {
            [self showAlertMessage:@"Could not find selected game"];
            return NO;
        }
    }
    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PredictionView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PredictionTableViewController *destination = [segue destinationViewController];
        Game *game = [self getGameForSection:indexPath.section andRow:indexPath.row];
        destination.selectedGame = game;
        destination.selectedPrediction = [[[RepositoryFactory getInstance] getPredictionRepository] getPredictionForGame:game.gameId];
    }
}

@end
