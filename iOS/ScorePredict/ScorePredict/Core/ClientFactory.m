//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import "ClientFactory.h"


@implementation ClientFactory

+ (MSClient *)getClient {
    NSURL *url = [NSURL URLWithString:@"https://scorepredict.azure-mobile.net"];
    MSClient *client = [MSClient clientWithApplicationURL:url
                                           applicationKey:@"pqhtjENleiEBDldYJmbyXsmVAUkvnI93"];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"UserId"] != nil && [defaults objectForKey:@"Token"] != nil) {
        NSString *userId = [defaults stringForKey:@"UserId"];
        NSString *token = [defaults stringForKey:@"Token"];

        MSUser *user = [[MSUser alloc] initWithUserId:userId];
        user.mobileServiceAuthenticationToken = token;
        client.currentUser = user;
    }

    return client;
    
    return nil;
}

@end