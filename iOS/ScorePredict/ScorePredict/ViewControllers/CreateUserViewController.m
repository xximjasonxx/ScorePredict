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
#import "ViewHelper.h"

@implementation CreateUserViewController
@synthesize usernameTextField, passwordTextField, confirmTextField;

UserService *userService;
CGFloat originalY;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    userService = [[UserService alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];;
    originalY = self.view.frame.origin.y;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField)
        [passwordTextField becomeFirstResponder];
    
    if (textField == passwordTextField)
        [confirmTextField becomeFirstResponder];
    
    if (textField == confirmTextField)
        [self createUser:nil];
    
    return YES;
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 originalY,
                                 self.view.frame.size.width,
                                 self.view.frame.size. height);
}

- (void)keyboardDidShow:(NSNotification *)sender
{
    CGRect frame = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect newFrame = [self.view convertRect:frame fromView:[[UIApplication sharedApplication] delegate].window];
    CGFloat keyboardYPosition = newFrame.origin.y;
    CGFloat yPosition = confirmTextField.frame.origin.y + confirmTextField.frame.size.height + 8;
    
    if (yPosition > keyboardYPosition)
    {
        // textfield is appearing underneath the keyboard
        // need to shift the view up
        CGFloat difference = yPosition - keyboardYPosition;
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     self.view.frame.origin.y - difference,
                                     self.view.frame.size.width,
                                     self.view.frame.size. height);
    }
}

-(IBAction)createUser:(id)sender
{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    [confirmTextField resignFirstResponder];
    
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
    [ViewHelper showWaitingView:self.navigationController.view];
    [userService createUser:username
                   password:password
                   complete:^(NSDictionary *data) {
                       [ViewHelper hideWaitingView];
                       [self handleSuccessfulUserCreateWithData:data];
                   } error:^(NSString *errorMessage) {
                       [ViewHelper hideWaitingView];
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
