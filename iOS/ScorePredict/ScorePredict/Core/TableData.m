//
//  TableData.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "TableData.h"

@implementation TableData
@synthesize tableCell, label, value;

-(id) initWithTableCell:(NSString *)pCellName withLabel:(NSString *)pLabel withVaue:(NSString *)pValue
{
    if (self = [super init]) {
        self.tableCell = pCellName;
        self.label = pLabel;
        self.value = pValue;
    }
    
    return self;
}

@end
