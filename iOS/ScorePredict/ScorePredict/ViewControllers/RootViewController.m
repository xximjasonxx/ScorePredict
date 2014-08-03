//
//  RootViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/23/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "InitViewController.h"
#import "ClientFactory.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@implementation RootViewController

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"UserId"] != nil && [defaults objectForKey:@"Token"] != nil) {
        [self goToMainView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)executeLogin:(id)sender
{
    MSClient *client = [ClientFactory getClient];
    [client loginWithProvider:@"facebook" controller:self animated:YES completion:^(MSUser *user, NSError *error) {
        if (error == nil) {
            // store the credentials
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:user.userId forKey:@"UserId"];
            [defaults setValue:user.mobileServiceAuthenticationToken forKey:@"Token"];
            [defaults synchronize];
            
            [self goToMainView];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                                message:@"The Login attempt was cancelled"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

-(void) loginComplete:(NSNotification*)notification {
    
    AppDelegate *authObj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    authObj.authenticated = YES;
    
    [self goToMainView];
}

- (void)goToMainView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InitViewController *mainView =  (InitViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MainView"];
    [mainView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:mainView animated:NO completion:nil];
}

@end
