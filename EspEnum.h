//
//  EspEnum.h
//  IOT_Espressif_IOS
//
//  Created by 白 桦 on 11/11/14.
//  Copyright (c) 2014 白 桦. All rights reserved.
//

#ifndef IOT_Espressif_IOS_EspEnum_h
#define IOT_Espressif_IOS_EspEnum_h

#include "EspHttpStatusConstants.h"

#pragma mark - Login Result Enum
typedef enum
{
    LOGIN_SUC = HTTP_STATUS_OK,
    LOGIN_PASSWORD_ERR = HTTP_STATUS_FORBIDDEN,
    LOGIN_NOT_REGISTER = HTTP_STATUS_NOT_FOUND,
    LOGIN_NETWORK_UNACCESSIBLE = -HTTP_STATUS_OK
}ESPLoginResultEnum;

#pragma mark - Apns Register Result Enum
typedef enum
{
    APNS_REGISTER_SUC = HTTP_STATUS_OK,
    APNS_REGISTER_USER_KEY_ERR = HTTP_STATUS_FORBIDDEN,
    APNS_REGISTER_APNS_TOKEN_ERR = HTTP_STATUS_BAD_REQUEST,
    APNS_REGISTER_NETWORK_UNACCESSIBLE = -HTTP_STATUS_OK
}ESPApnsRegisterResultEnum;

#pragma mark - Apns Unregister Result Enum
typedef enum
{
    APNS_UNREGISTER_SUC = HTTP_STATUS_OK,
    APNS_UNREGISTER_APNS_TOKEN_ERR = HTTP_STATUS_BAD_REQUEST,
    APNS_UNREGISTER_NETWORK_UNACCESSIBLE = -HTTP_STATUS_OK
}ESPApnsUnregisterResultEnum;

#pragma makrk - Notify Result Enum
typedef enum
{
    NOTIFY_SUC = HTTP_STATUS_OK,
    NOTIFY_NETWORK_UNACCESSIBLE = -HTTP_STATUS_OK
}ESPNotifyResultEnum;

#endif