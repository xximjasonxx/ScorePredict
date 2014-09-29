//
//  PregamePredictionTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "PregamePredictionTableViewController.h"
#import "PredictionService.h"
#import "ViewHelper.h"

@implementation PregamePredictionTableViewController
@synthesize awayLabel, awayScore, homeLabel, homeScore;
@synthesize game, prediction;

PredictionService *predictionService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    predictionService = [[PredictionService alloc] init];
    
    // set the game information
    awayLabel.text = [game getAwayCity];
    homeLabel.text = [game getHomeCity];
    
    if (prediction != nil)
    {
        awayScore.text = [NSString stringWithFormat:@"%d", prediction.predictedAwayScore];
        homeScore.text = [NSString stringWithFormat:@"%d", prediction.predictedHomeScore];
    }
    
    [awayScore becomeFirstResponder];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (IBAction)save:(id)sender {
    // validate that non empty numeric entries were provided
    if ([awayScore.text isEqualToString:@""] || [homeScore.text isEqualToString:@""])
    {
        [self showErrorAlert:@"Please provide both an Away and Home score"];
        return;
    }
    
    int predictedAwayScore = [self.awayScore.text intValue];
    int predictedHomeScore = [self.homeScore.text intValue];
    
    [ViewHelper showWaitingView:self.navigationController.view];
    [predictionService savePredictionFor:game.gameId
                           withAwayScore:predictedAwayScore
                            andHomeScore:predictedHomeScore
                                  inWeek:game.weekNo
                               andInYear:game.year
                              onComplete:^{
                                  [self performSegueWithIdentifier:@"madePrediction" sender:self];
                              } onError:^(NSString *message) {
                                  [ViewHelper hideWaitingView];
                                  [self showErrorAlert:message];
                              }];
}

-(void)showErrorAlert:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    [alertView show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    return;
}

@end
