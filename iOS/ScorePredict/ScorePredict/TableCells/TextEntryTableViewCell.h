//
//  TextEntryTableViewCell.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextEntryTableViewCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UITextField *entryField;

-(void)initWithLabel:(NSString *)labelString;

@end
