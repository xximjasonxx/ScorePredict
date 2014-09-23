//
//  LoginViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 8/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic, retain) IBOutlet UITextField *usernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;

- (IBAction)login:(id)sender;

@end
