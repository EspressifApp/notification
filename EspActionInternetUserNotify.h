//
//  EspActionInternetUserNotifiy.h
//  notification
//
//  Created by 白 桦 on 12/18/15.
//  Copyright © 2015 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EspEnum.h"

@protocol EspActionInternetUserNotifyDelegate <NSObject>

/**
 * Notify the user by Apns
 * @param userKey the user key gotten from http://iot.espressif.cn
 * @param message the message to be sent
 *
 * @return ESPNotifyResultEnum
 */
-(ESPNotifyResultEnum) doActionInternetUserNotifyWithUserkey: (NSString *) userKey andMessage: (NSString *) message;

@end

@interface EspActionInternetUserNotifiy : NSObject<EspActionInternetUserNotifyDelegate>

@end

