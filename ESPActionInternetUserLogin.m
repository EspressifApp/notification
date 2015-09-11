//
//  ESPActionInternetUserLoginActor.m
//  IOT_Espressif_IOS
//
//  Created by 白 桦 on 11/12/14.
//  Copyright (c) 2014 白 桦. All rights reserved.
//

#import "ESPActionInternetUserLogin.h"
#import "ESPHttpClient.h"
#import "ESPUser.h"
#import "EspUrlConstants.h"

@implementation ESPActionInternetUserLogin

-(ESPLoginResultEnum) doActionInternetUserLoginWithEmail: (NSString *) email
                                               password : (NSString *) password
{
    NSLog(@"doActionInternetUserLoginWithEmail::email=%@,password=%@",email,password);
    
    // check whether email is empty
    if ([email length] == 0)
    {
        return LOGIN_NOT_REGISTER;
    }
    
    // generate http body
    NSDictionary *httpBody = [NSDictionary dictionaryWithObjectsAndKeys:email, ESP_CONSTANTS_EMAIL, password,ESP_CONSTANTS_PASSWORD,ESP_CONSTANTS_USER,ESP_CONSTANTS_SCOPE,nil];
    // get http response
    NSDictionary *httpResponse = [ESPHttpClient postSynPath:ESP_URL_LOGIN headers:nil parameters:httpBody timeoutSeconds:ESP_SERVER_TIMEOUT_SECONDS];
    // check whether httpResponse is nil
    if(httpResponse==nil)
    {
        return LOGIN_NETWORK_UNACCESSIBLE;
    }
    // process http response
    NSNumber *status = [httpResponse objectForKey:ESP_CONSTANTS_STATUS];
    NSDictionary *key = [httpResponse objectForKey:ESP_CONSTANTS_KEY];
    ESPLoginResultEnum result = [status intValue];
    switch (result)
    {
        case LOGIN_SUC:
        {
            NSString *userKey = [key objectForKey:ESP_CONSTANTS_TOKEN];
            NSNumber *userId = [key objectForKey:ESP_CONSTANTS_USER_ID];
            ESPUser *user = [ESPUser sharedInstance];
            [user setUserEmail:email];
            [user setUserPassword:password];
            [user setUserKey:userKey];
            [user setUserId:[userId longValue]];
            return LOGIN_SUC;
        }
        case LOGIN_NOT_REGISTER:
            return LOGIN_NOT_REGISTER;
        case LOGIN_PASSWORD_ERR:
            return LOGIN_PASSWORD_ERR;
        case LOGIN_NETWORK_UNACCESSIBLE:
            return LOGIN_NETWORK_UNACCESSIBLE;
    }
    // code shouldn't run here
    NSLog(@"ERROR... Code shouldn't run here");
    return LOGIN_NETWORK_UNACCESSIBLE;
}

@end
