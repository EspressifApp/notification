
//
//  EspViewController.m
//  notification
//
//  Created by 白 桦 on 9/9/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import "EspViewController.h"
#import "ESPUser.h"

@implementation EspViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"on viewDidLoad");
//    ESPLoginResultEnum result = [[ESPUser sharedInstance] doActionInternetUserLoginWithEmail:@"12345a@qq.com" password:@"1112"];
    ESPLogoutResultEnum result = [[ESPUser sharedInstance] doActionInternetUserLogout];
    NSLog(@"result is %d",result);
}

@end
