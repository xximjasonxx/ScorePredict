//
//  RootViewController.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/23/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewProtocol <NSObject>

- (void)dismissAndLoginView;

@end

@interface RootViewController : UIViewController
@property (nonatomic, weak) id <LoginViewProtocol> delegate;

-(IBAction)returnToMain:(UIStoryboardSegue *)segue;

@end
