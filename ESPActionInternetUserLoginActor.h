//
//  ESPActionInternetUserLoginActor.h
//  IOT_Espressif_IOS
//
//  Created by 白 桦 on 11/12/14.
//  Copyright (c) 2014 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EspEnum.h"

@protocol ESPActionInternetUserLoginDelegate <NSObject>

/**
 * Login in http://iot.espressif.cn
 * @param email The email of the user
 * @param password The password of the user
 *
 * @return ESPLoginResultEnum
 */
-(ESPLoginResultEnum) doActionInternetUserLoginWithEmail:(NSString *) email
                                               password :(NSString *) password;
@end

@interface ESPActionInternetUserLoginActor : NSObject<ESPActionInternetUserLoginDelegate>
@end
