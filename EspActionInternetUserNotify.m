//
//  EspActionInternetUserNotifiy.m
//  notification
//
//  Created by 白 桦 on 12/18/15.
//  Copyright © 2015 白 桦. All rights reserved.
//

#import "EspActionInternetUserNotify.h"
#import "ESPHttpClient.h"
#import "ESPUser.h"
#import "EspUrlConstants.h"

@implementation EspActionInternetUserNotifiy

-(ESPNotifyResultEnum) doActionInternetUserNotifyWithUserkey: (NSString *) userKey andMessage: (NSString *) message
{
    NSLog(@"doActionInternetUserApnsUnregisterWithApnsToken::userKey=%@,message=%@",userKey,message);
    
    // generate url
    NSString *httpUrl = [NSString stringWithFormat:@"https://iot.espressif.cn/v1/user/notify/"];
    
    // generate http body
    // generate http header
    NSString *headerToken = [NSString stringWithFormat:@"token %@",userKey];
    NSDictionary *httpHeader = [NSDictionary dictionaryWithObject:headerToken forKey:@"Authorization"];
    NSDictionary *httpBody = [NSDictionary dictionaryWithObject:message forKey:@"alert"];
    
    // get http response
    NSDictionary *httpResponse = [ESPHttpClient postSynPath:httpUrl headers:httpHeader parameters:httpBody timeoutSeconds:ESP_SERVER_TIMEOUT_SECONDS];
    
    // check whether httpResponse is nil
    if(httpResponse==nil)
    {
        return NOTIFY_NETWORK_UNACCESSIBLE;
    }
    else{
        return NOTIFY_SUC;
    }
}
@end
