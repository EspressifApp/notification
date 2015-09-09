//
//  ESPActionInternetUserLogoutActor.m
//  notification
//
//  Created by 白 桦 on 9/9/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import "ESPActionInternetUserLogoutActor.h"
#import "ESPHttpClient.h"
#import "ESPUser.h"
#include "EspUrlConstants.h"

@implementation ESPActionInternetUserLogoutActor

-(ESPLogoutResultEnum) doActionInternetUserLogout
{
    NSLog(@"doActionInternetUserLogout");
    
    // generate http body
//    NSDictionary *httpBody = [NSDictionary dictionaryWithObjectsAndKeys:email, ESP_CONSTANTS_EMAIL, password,ESP_CONSTANTS_PASSWORD,ESP_CONSTANTS_USER,ESP_CONSTANTS_SCOPE,nil];
    
    // get http response
    NSDictionary *httpResponse = [ESPHttpClient postSynPath:ESP_URL_LOGOUT headers:nil parameters:nil timeoutSeconds:ESP_SERVER_TIMEOUT_SECONDS];
    
    // check whether httpResponse is nil
    if(httpResponse==nil)
    {
        return LOGOUT_NETWORK_UNACCESSIBLE;
    }
    // process http response
    NSNumber *status = [httpResponse objectForKey:ESP_CONSTANTS_STATUS];
//    NSArray *keys = [httpResponse objectForKey:ESP_CONSTANTS_KEYS];
    ESPLogoutResultEnum result = [status intValue];
    switch (result)
    {
        case LOGOUT_SUC:
            return LOGOUT_SUC;
        case LOGOUT_NETWORK_UNACCESSIBLE:
            return LOGOUT_NETWORK_UNACCESSIBLE;
    }
    // code shouldn't run here
    NSLog(@"ERROR... Code shouldn't run here");
    return LOGOUT_NETWORK_UNACCESSIBLE;
}

@end
