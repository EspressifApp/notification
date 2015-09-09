//
//  ESPActionInternetUserLogoutActor.h
//  notification
//
//  Created by 白 桦 on 9/9/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EspEnum.h"

@protocol ESPActionInternetUserLogoutDelegate <NSObject>

/**
 * Logout in http://iot.espressif.cn
 *
 * @return ESPLoginResultEnum
 */
-(ESPLogoutResultEnum) doActionInternetUserLogout;
@end

@interface ESPActionInternetUserLogoutActor : NSObject<ESPActionInternetUserLogoutDelegate>
@end
