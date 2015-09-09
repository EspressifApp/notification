//
//  ESPUser.m
//  IOT_Espressif_IOS
//
//  Created by 白 桦 on 11/11/14.
//  Copyright (c) 2014 白 桦. All rights reserved.
//

#import "ESPUser.h"
#import "ESPHttpClient.h"
#include "EspUrlConstants.h"
#include "EspEnum.h"

@implementation ESPUser

#pragma mark - Single Pattern
// Single Pattern
static ESPUser *sharedInstance = nil;

+ (ESPUser *) sharedInstance
{
    @synchronized (self)
    {
        if(sharedInstance == nil)
        {
            sharedInstance = [[self alloc]init];
        }
    }
    return sharedInstance;
}
- (id)init
{
    self = [super init];
    if(self)
    {
        // first init
    }
    return self;
}

#pragma mark - implemet ESPActionInternetUserLoginDelegate
-(ESPLoginResultEnum) doActionInternetUserLoginWithEmail: (NSString *) email
                                               password : (NSString *) password
{
    id<ESPActionInternetUserLoginDelegate> actor =[ESPActionInternetUserLoginActor alloc];
    return [actor doActionInternetUserLoginWithEmail:email password:password];
}

#pragma mark - implemet ESPActionInternetUserLogoutDelegate
-(ESPLogoutResultEnum) doActionInternetUserLogout
{
    id<ESPActionInternetUserLogoutDelegate> actor = [ESPActionInternetUserLogoutActor alloc];
    return [actor doActionInternetUserLogout];
}
@end
