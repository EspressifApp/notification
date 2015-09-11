//
//  EspActionInternetUserRegister.m
//  notification
//
//  Created by 白 桦 on 9/10/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import "EspActionInternetUserApnsRegister.h"
#import "ESPHttpClient.h"
#import "ESPUser.h"
#import "EspUrlConstants.h"

@implementation EspActionInternetUserApnsRegister

-(ESPApnsRegisterResultEnum) doActionInternetUserApnsRegisterWithUserKey: (NSString *) userKey
                                                            AndApnsToken: (NSString *) apnsToken
                                                          AndDeviceToken: (NSString *) deviceToken;
{
    NSLog(@"doActionInternetUserUserKey::userKey=%@,apnsToken=%@,deviceToken=%@",userKey,apnsToken,deviceToken);
    
    // generate url
    NSString *httpUrl = [NSString stringWithFormat:@"http://iot.espressif.cn/v1/pns/peer/?action=register&pns_token=apns-%@&peer_token=%@",apnsToken,deviceToken];
    NSString *headerToken = [NSString stringWithFormat:@"token %@",userKey];
    // generate http header
    NSDictionary *httpHeader = [NSDictionary dictionaryWithObject:headerToken forKey:@"Authorization"];

    // get http response
    NSDictionary *httpResponse = [ESPHttpClient postSynPath:httpUrl headers:httpHeader parameters:nil timeoutSeconds:ESP_SERVER_TIMEOUT_SECONDS];
    
    // check whether httpResponse is nil
    if(httpResponse==nil)
    {
        return APNS_REGISTER_NETWORK_UNACCESSIBLE;
    }
    // process http response
    NSNumber *status = [httpResponse objectForKey:ESP_CONSTANTS_STATUS];
    ESPApnsRegisterResultEnum result = [status intValue];
    switch (result)
    {
        case APNS_REGISTER_SUC:
            return APNS_REGISTER_SUC;
        case APNS_REGISTER_USER_KEY_ERR:
            return APNS_REGISTER_USER_KEY_ERR;
        case APNS_REGISTER_APNS_TOKEN_ERR:
            return APNS_REGISTER_APNS_TOKEN_ERR;
        case APNS_REGISTER_NETWORK_UNACCESSIBLE:
            return APNS_REGISTER_NETWORK_UNACCESSIBLE;
    }
    // code shouldn't run here
    NSLog(@"ERROR... Code shouldn't run here");
    return APNS_REGISTER_NETWORK_UNACCESSIBLE;
}


@end
