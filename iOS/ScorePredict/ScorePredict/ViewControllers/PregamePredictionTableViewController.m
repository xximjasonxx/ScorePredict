//
//  PregamePredictionTableViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/28/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "PregamePredictionTableViewController.h"
#import "PredictionService.h"

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
    
    int value = [awayScore.text intValue];
    return;
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

@end
