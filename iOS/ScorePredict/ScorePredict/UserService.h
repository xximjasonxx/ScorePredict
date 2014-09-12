//
//  UserService.h
//  ScorePredict
//
//  Created by Jason Farrell on 9/7/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserService : NSObject

// methods
-(void)createUser:(NSString *)username
         password:(NSString *)password
         complete:(void (^)(NSDictionary* data))completeHandler
            error:(void (^)(NSString *errorMessage))errorHandler;
@end
