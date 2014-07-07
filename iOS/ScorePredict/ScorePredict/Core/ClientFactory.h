//
// Created by Jason Farrell on 12/27/13.
// Copyright (c) 2013 Jason Farrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface ClientFactory : NSObject

// define the class method that will return us the client
// if authentication is available it will be added on
+ (MSClient *) getClient;

@end