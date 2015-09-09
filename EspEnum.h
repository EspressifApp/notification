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

#pragma mark - Logout Result Enum
typedef enum
{
    LOGOUT_SUC = HTTP_STATUS_OK,
    LOGOUT_NETWORK_UNACCESSIBLE = -HTTP_STATUS_OK
}ESPLogoutResultEnum;

#pragma mark - Register Result Enum
typedef enum
{
    REGISTER_SUC = HTTP_STATUS_OK,
    REGISTER_USER_OR_EMAIL_EXIST_ALREADY = HTTP_STATUS_CONFLICT,
    REGISTER_USER_OR_EMAIL_ERR_FORMAT = HTTP_STATUS_BAD_REQUEST,
    REGISTER_NETWORK_UNACCESSIBLE = -HTTP_STATUS_OK
}ESPRegisterResultEnum;

#endif