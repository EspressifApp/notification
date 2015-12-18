//
//  AppDelegate.m
//  notification
//
//  Created by 白 桦 on 9/7/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import "AppDelegate.h"
#import "EspViewController.h"
#import "ESPUser.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // remove badge when ios become active
    NSLog(@"applicationDidBecomeActive: remove badge");
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    
    // update my token in UI
    EspViewController *vc = (EspViewController *)self.window.rootViewController;
    NSString *token = [self getHexStringByData:deviceToken];
    NSLog(@"label token: %@",token);
    vc.labelToken.text = token;
    
    ESPUser *user = [ESPUser sharedInstance];
    user.deviceToken = token;
}

- (NSString *) getHexStringByData:(NSData *)data
{
    NSMutableString* mStr = [[NSMutableString alloc]init];
    NSUInteger totalLen = [data length];
    Byte bytes[totalLen];
    [data getBytes:&bytes length:totalLen];
    for (int i = 0; i < totalLen; i++)
    {
        NSString *hexString = [[NSString alloc]initWithFormat:@"%.2x",bytes[i]];
        [mStr appendString:hexString];
    }
    return mStr;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to get token, error: %@", error);
    
    // update my token in UI
    EspViewController *vc = (EspViewController *)self.window.rootViewController;
    vc.labelToken.text = [NSString stringWithFormat:@"Failed to get token, error: %@",error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Remote notification arrived: %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
    //#pragma send a local notification
    //    UIApplication *app = [UIApplication sharedApplication];
    //    // remove all prior notifications
    //    NSArray *scheduled = [app scheduledLocalNotifications];
    //    if (scheduled)
    //    {
    //        [app cancelAllLocalNotifications];
    //    }
    //
    //    // create a new notification
    //    UILocalNotification* alarm = [[UILocalNotification alloc]init];
    //    if (alarm)
    //    {
    //        alarm.fireDate = [NSDate date];
    //        alarm.timeZone = [NSTimeZone defaultTimeZone];
    //        alarm.repeatInterval = 0;
    //        alarm.alertBody = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    //        [app scheduleLocalNotification:alarm];
    //    }
    
#pragma alert when app is active
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive)
    {
        NSString *title = @"APNS Notification";
        NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        NSString *cancelButtonTitle = @"I know";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
        [alertView show];
    }   

}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
