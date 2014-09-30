//
//  CurrentWeekTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/25/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "CurrentWeekTableViewController.h"
#import "PregamePredictionTableViewController.h"
#import "GameFinalTableViewController.h"
#import "GamePredictionFinalTableViewController.h"
#import "SWRevealViewController.h"

#import "HomeViewTableViewCell.h"
#import "RepositoryFactory.h"
#import "CurrentWeekService.h"
#import "Game.h"
#import "ViewHelper.h"

@implementation CurrentWeekTableViewController
@synthesize games, menuItem;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.games = [[NSMutableDictionary alloc] init];
    self.title = @"";
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    menuItem.target = self.revealViewController;
    menuItem.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"UserId"];
    NSString *token = [defaults objectForKey:@"Token"];
    
    CurrentWeekService *service = [[CurrentWeekService alloc] initWithDelegate:self];
    
    [ViewHelper showWaitingView:self.navigationController.view];
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
    
    [ViewHelper hideWaitingView];
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
        cell.awayTeam.text = [game.awayTeamAbbr uppercaseString];
        cell.homeTeam.text = [game.homeTeamAbbr uppercaseString];
        
        if ([game.gameState.lowercaseString isEqualToString:@"ip"]) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the selected game
    Game *selectedGame = [self getGameForSection:indexPath.section andRow:indexPath.row];
    if ([selectedGame isConcluded])
    {
        PredictionRepository *predictionRepo = [[RepositoryFactory getInstance] getPredictionRepository];
        Prediction *prediction = [predictionRepo getPredictionForGame:selectedGame.gameId];
        if (prediction != nil) {
            [self performSegueWithIdentifier: @"ConcludedGamePrediction" sender: self];
        }
        else {
            [self performSegueWithIdentifier: @"ConcludedGameNoPrediction" sender: self];
        }
    }
    
    if ([selectedGame inPregame])
    {
        [self performSegueWithIdentifier: @"Pregame" sender: self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Game *game = [self getGameForSection:indexPath.section andRow:indexPath.row];
    
    if ([[segue identifier] isEqualToString:@"ConcludedGamePrediction"]) {
        GamePredictionFinalTableViewController *destination = [segue destinationViewController];
        destination.game = game;
        destination.prediction = [[[RepositoryFactory getInstance] getPredictionRepository] getPredictionForGame:game.gameId];
    }

    if ([[segue identifier] isEqualToString:@"ConcludedGameNoPrediction"]) {
        GameFinalTableViewController *destination = [segue destinationViewController];
        destination.game = game;
    }
    
    if ([[segue identifier] isEqualToString:@"Pregame"]) {
        PregamePredictionTableViewController *destination = [segue destinationViewController];
        destination.game = game;
        destination.prediction = [[[RepositoryFactory getInstance] getPredictionRepository] getPredictionForGame:game.gameId];
    }
}

-(IBAction)madePerdiction:(UIStoryboardSegue *)storyboard
{
}

@end
