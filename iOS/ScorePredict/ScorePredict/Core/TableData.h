//
//  TableData.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableData : NSObject
@property (nonatomic, weak) NSString *tableCell;
@property (nonatomic, weak) NSString *label;
@property (nonatomic, weak) NSString *value;

-(id) initWithTableCell:(NSString *)pCellName withLabel:(NSString *)pLabel withVaue:(NSString *)pValue;

@end
