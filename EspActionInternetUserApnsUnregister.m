//
//  EspActionInternetUserUnregister.m
//  notification
//
//  Created by 白 桦 on 9/10/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import "EspActionInternetUserApnsUnregister.h"
#import "ESPHttpClient.h"
#import "ESPUser.h"
#import "EspUrlConstants.h"

@implementation EspActionInternetUserApnsUnregister

-(ESPApnsUnregisterResultEnum) doActionInternetUserApnsUnregisterWithApnsToken: (NSString *) apnsToken
                                                                andDeviceToken: (NSString *) deviceToken
{
    NSLog(@"doActionInternetUserApnsUnregister::apnsToken=%@,deviceToken=%@",apnsToken,deviceToken);
    
    // generate url
    NSString *httpUrl = [NSString stringWithFormat:@"http://iot.espressif.cn/v1/pns/peer/?action=unregister&pns_token=apns-%@&peer_token=%@",apnsToken,deviceToken];
    
    // get http response
    NSDictionary *httpResponse = [ESPHttpClient postSynPath:httpUrl headers:nil parameters:nil timeoutSeconds:ESP_SERVER_TIMEOUT_SECONDS];
    // check whether httpResponse is nil
    if(httpResponse==nil)
    {
        return APNS_UNREGISTER_NETWORK_UNACCESSIBLE;
    }
    // process http response
    NSNumber *status = [httpResponse objectForKey:ESP_CONSTANTS_STATUS];
    ESPApnsUnregisterResultEnum result = [status intValue];
    switch (result)
    {
        case APNS_UNREGISTER_SUC:
            return APNS_UNREGISTER_SUC;
        case APNS_UNREGISTER_APNS_TOKEN_ERR:
            return APNS_UNREGISTER_APNS_TOKEN_ERR;
        case APNS_UNREGISTER_NETWORK_UNACCESSIBLE:
            return APNS_UNREGISTER_NETWORK_UNACCESSIBLE;
    }
    // code shouldn't run here
    NSLog(@"ERROR... Code shouldn't run here");
    return APNS_UNREGISTER_NETWORK_UNACCESSIBLE;
}
@end
