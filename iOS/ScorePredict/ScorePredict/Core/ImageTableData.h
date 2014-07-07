//
//  ImageTableData.h
//  ScorePredict
//
//  Created by Jason Farrell on 6/29/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import "TableData.h"

@interface ImageTableData : TableData
@property (nonatomic, weak) UIImage *image;

-(id) initWithTableCell:(NSString *)pCellName withLabel:(NSString *)pLabel withValue:(NSString *)pValue andImage:(UIImage *)pImage;

@end
