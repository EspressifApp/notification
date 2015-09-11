//
//  EspActionInternetUserUnregister.h
//  notification
//
//  Created by 白 桦 on 9/10/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EspEnum.h"

@protocol EspActionInternetUserApnsUnregisterDelegate <NSObject>

/**
 * Unregister apns in http://iot.espressif.cn
 * @param apnsToken the apns token applied by http://iot.espressif.cn
 * @param deviceToken the iphone's device token used by apns
 *
 * @return ESPApnsRegisterResultEnum
 */
-(ESPApnsUnregisterResultEnum) doActionInternetUserApnsUnregisterWithApnsToken: (NSString *) apnsToken
                                                                andDeviceToken: (NSString *) deviceToken;

@end

@interface EspActionInternetUserApnsUnregister : NSObject<EspActionInternetUserApnsUnregisterDelegate>

@end