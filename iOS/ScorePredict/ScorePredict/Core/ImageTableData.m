//
//  ImageTableData.m
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "ImageTableData.h"

@implementation ImageTableData
@synthesize image;

-(id) initWithTableCell:(NSString *)pCellName withLabel:(NSString *)pLabel withValue:(NSString *)pValue andImage:(UIImage *)pImage
{
    if (self = [super initWithTableCell:pCellName withLabel:pLabel withVaue:pValue]) {
        self.image = pImage;
    }
    
    return self;
}

@end
