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

#define APNS_TOKEN @"dafc628ed4004c4752fc2f1d8df4f5c4ac7ddf51"

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
        self.apnsToken = APNS_TOKEN;
    }
    return self;
}

#pragma mark - implement ESPActionInternetUserLoginDelegate
-(ESPLoginResultEnum) doActionInternetUserLoginWithEmail: (NSString *) email
                                                password: (NSString *) password
{
    id<ESPActionInternetUserLoginDelegate> action =[ESPActionInternetUserLogin alloc];
    return [action doActionInternetUserLoginWithEmail:email password:password];
}

#pragma mark - implement ESPActionInternetUserApnsRegisterDelegate
-(ESPApnsRegisterResultEnum) doActionInternetUserApnsRegisterWithUserKey: (NSString *) userKey
                                                            AndApnsToken: (NSString *) apnsToken
                                                          AndDeviceToken: (NSString *) deviceToken
{
    id<EspActionInternetUserApnsRegisterDelegate> action = [EspActionInternetUserApnsRegister alloc];
    return [action doActionInternetUserApnsRegisterWithUserKey:userKey AndApnsToken:apnsToken AndDeviceToken:deviceToken];
}

#pragma mark - implement ESPActionInternetUserApnsUnregisterDelegate
-(ESPApnsUnregisterResultEnum) doActionInternetUserApnsUnregisterWithApnsToken: (NSString *) apnsToken
                                                                andDeviceToken: (NSString *) deviceToken;
{
    id<EspActionInternetUserApnsUnregisterDelegate> action = [EspActionInternetUserApnsUnregister alloc];
    return [action doActionInternetUserApnsUnregisterWithApnsToken:apnsToken andDeviceToken:deviceToken];
}

//-(ESPNotifyResultEnum) EspActionInternetUserNotifyDelegate: (NSString *) userKey andMessage: (NSString *) message;
#pragma mark - implement EspActionInternetUserNotifyDelegate
-(ESPNotifyResultEnum) doActionInternetUserNotifyWithUserkey: (NSString *) userKey andMessage: (NSString *) message
{
    id<EspActionInternetUserNotifyDelegate> action = [EspActionInternetUserNotifiy alloc];
    return [action doActionInternetUserNotifyWithUserkey:userKey andMessage:message];
}

@end
