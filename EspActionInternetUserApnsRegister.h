//
//  EspActionInternetUserRegister.h
//  notification
//
//  Created by 白 桦 on 9/10/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EspEnum.h"

@protocol EspActionInternetUserApnsRegisterDelegate <NSObject>

/**
 * Register apns in http://iot.espressif.cn
 * @param userKey the user key of the user
 * @param apnsToken the apns token applied by http://iot.espressif.cn
 * @param deviceToken the iphone's device token used by apns
 *
 * @return ESPApnsRegisterResultEnum
 */
-(ESPApnsRegisterResultEnum) doActionInternetUserApnsRegisterWithUserKey: (NSString *) userKey
                                                            AndApnsToken: (NSString *) apnsToken
                                                          AndDeviceToken: (NSString *) deviceToken;

@end

@interface EspActionInternetUserApnsRegister : NSObject<EspActionInternetUserApnsRegisterDelegate>

@end
