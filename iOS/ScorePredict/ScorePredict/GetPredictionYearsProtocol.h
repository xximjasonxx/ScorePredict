//
//  GetPredictionYearsProtocol.h
//  ScorePredict
//
//  Created by Jason Farrell on 7/6/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetPredictionYearsProtocol <NSObject>

@required
-(void)predictionYearsRetrieved:(NSArray *) years;
-(void)retrievalFailed;

@end
