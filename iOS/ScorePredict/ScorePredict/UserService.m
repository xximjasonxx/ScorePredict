//
//  UserService.m
//  ScorePredict
//
//  Created by Jason Farrell on 9/7/14.
//  Copyright (c) 2014 Farrellsoft. All rights reserved.
//

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

#import "UserService.h"
#import "ClientFactory.h"

@implementation UserService

-(void)createUser:(NSString *)username password:(NSString *)password complete:(void (^)(NSDictionary *))completeHandler error:(void (^)(NSString *))errorHandler {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:username forKey:@"username"];
    [dictionary setObject:password forKey:@"password"];
    
    MSClient *client = [ClientFactory getClient];
    [client invokeAPI:@"create_user"
                 body:dictionary
           HTTPMethod:@"post"
           parameters:nil
              headers:nil
           completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
               if (error == nil) {
                   completeHandler((NSDictionary *)result);
               }
               else {
                   errorHandler(error.localizedDescription);
               }
    }];
}

@end
