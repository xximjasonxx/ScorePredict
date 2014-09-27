//
//  LoginViewController.m
//  ScorePredict
//
//  Created by Jason Farrell on 8/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "LoginViewController.h"
#import "UserService.h"
#import "ViewHelper.h"

@implementation LoginViewController
@synthesize usernameTextField, passwordTextField;

UserService *userService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    userService = [[UserService alloc] init];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField)
        [self.passwordTextField becomeFirstResponder];
    
    if (textField == self.passwordTextField)
        [self login:nil];
    
    return YES;
}

- (IBAction)login:(id)sender {
    NSString *username = usernameTextField.text;
    NSString *password = passwordTextField.text;
    
    if (username == nil || [self isEmpty:username] || password == nil || [self isEmpty:password])
    {
        [self showAlertMessage:@"Username and Password must be provided"];
        return;
    }
    
    [ViewHelper showWaitingView:self.view];
    [userService login:username
              password:password
              complete:^(NSDictionary *data) {
                  [ViewHelper hideWaitingView];
                  [self handleSuccessfulLogin:data];
              } error:^(NSString *errorMessage) {
                  [ViewHelper hideWaitingView];
                  [self showAlertMessage:errorMessage];
              }];
}

-(void)handleSuccessfulLogin:(NSDictionary *)data {
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

@end
