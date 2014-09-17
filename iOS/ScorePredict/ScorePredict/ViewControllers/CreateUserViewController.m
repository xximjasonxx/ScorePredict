//
//  CreateUserViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 8/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "CreateUserViewController.h"
#import "UserService.h"
#import "InitViewController.h"

@interface CreateUserViewController ()

@end

@implementation CreateUserViewController
@synthesize usernameTextField, passwordTextField, confirmTextField;

UserService *userService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    userService = [[UserService alloc] init];
}

-(IBAction)createUser:(id)sender
{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    // validate that username and password are not empty
    if ([self isEmpty:username] || [self isEmpty:password]) {
        [self showAlertMessage:@"Please provide a username and password"];
        return;
    }
    
    // validate the the password and confirm match
    NSString *confirm = self.confirmTextField.text;
    if (![password isEqualToString:confirm]) {
        [self showAlertMessage:@"Password and Confirm do not match"];
        return;
    }
    
    // attempt to create the user
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    [userService createUser:username
                   password:password
                   complete:^(NSDictionary *data) {
                       [self handleSuccessfulUserCreateWithData:data];
                   } error:^(NSString *errorMessage) {
                       [self showAlertMessage:errorMessage];
                   }];
}

// validation methods
-(BOOL) isEmpty:(NSString *)fieldValue {
    if (fieldValue == nil)
        return true;
    
    NSString *trimmedString = [fieldValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [trimmedString isEqualToString:@""];
}

-(void)showAlertMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    [alertView show];
}

-(void)handleSuccessfulUserCreateWithData:(NSDictionary *)data {
    // get the values from the data
    NSString *userId = [data objectForKey:@"id"];
    NSString *token = [data objectForKey:@"token"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:userId forKey:@"UserId"];
    [defaults setValue:token forKey:@"Token"];
    [defaults synchronize];
    
    [self goToMainView];
}

- (void)goToMainView {
    [self.navigationController performSegueWithIdentifier:@"showApp" sender:self.navigationController];
}

@end
