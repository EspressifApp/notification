//
//  ESPUser.h
//  IOT_Espressif_IOS
//
//  Created by 白 桦 on 11/11/14.
//  Copyright (c) 2014 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "EspEnum.h"
#include "ESPActionInternetUserLogin.h"
#include "EspActionInternetUserApnsRegister.h"
#include "EspActionInternetUserApnsUnregister.h"
#include "EspActionInternetUserNotify.h"


@interface ESPUser : NSObject<ESPActionInternetUserLoginDelegate,EspActionInternetUserApnsRegisterDelegate,EspActionInternetUserApnsUnregisterDelegate
,EspActionInternetUserNotifyDelegate>

+ (ESPUser *) sharedInstance;

@property (atomic,copy) NSString *userName;
@property (atomic,copy) NSString *userKey;
@property (atomic,copy) NSString *userEmail;
@property (atomic,copy) NSString *userPassword;
@property (atomic,assign) long userId;
@property (atomic,strong) NSMutableArray *deviceList;
@property (atomic,strong) NSString *apnsToken;
@property (atomic,strong) NSString *deviceToken;

@end
