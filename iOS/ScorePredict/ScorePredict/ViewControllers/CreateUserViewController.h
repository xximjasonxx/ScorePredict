//
//  CreateUserViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 8/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateUserViewController : UIViewController

// properties
@property (nonatomic, retain) IBOutlet UITextField *usernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property (nonatomic, retain) IBOutlet UITextField *confirmTextField;

// methods
-(IBAction)createUser:(id)sender;

@end
