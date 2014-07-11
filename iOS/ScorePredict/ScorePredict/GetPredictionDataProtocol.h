//
//  GetPredictionYearsProtocol.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/6/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetPredictionDataProtocol <NSObject>

@required
-(void)predictionDataRetrieved:(NSArray *) predictionData;
-(void)retrievalFailed;

@end
