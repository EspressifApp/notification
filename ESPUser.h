//
//  ESPUser.h
//  IOT_Espressif_IOS
//
//  Created by 白 桦 on 11/11/14.
//  Copyright (c) 2014 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "EspEnum.h"
#include "ESPActionInternetUserLoginActor.h"
#include "ESPActionInternetUserLogoutActor.h"

@interface ESPUser : NSObject<ESPActionInternetUserLoginDelegate>

+ (ESPUser *) sharedInstance;

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userKey;
@property (nonatomic,copy) NSString *userEmail;
@property (nonatomic,copy) NSString *userPassword;
@property (nonatomic,assign) long userId;
@property (nonatomic,strong) NSMutableArray *deviceList;

-(ESPLoginResultEnum) doActionInternetUserLoginWithEmail: (NSString *) email
                                               password : (NSString *) password;

-(ESPLogoutResultEnum) doActionInternetUserLogout;

@end
