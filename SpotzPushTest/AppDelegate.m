//
//  AppDelegate.m
//  SpotzPushTest
//
//  Created by Melvin Artemas on 27/01/2015.
//  Copyright (c) 2015 Localz Pty Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "SpotzPush.h"

@interface AppDelegate ()<CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSString *latitude;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSString *altitude;
@property (nonatomic) NSString *speed;

@property (nonatomic, copy) void (^fetchHandler)(UIBackgroundFetchResult);

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SpotzPushConfig shared].isDebug = YES;
    
    [SpotzPush initWithProjectId:@"34e1fe13-42f4-46b5-9b64-1df1b2750588" projectKey:@"c5e3a5a8-d410-4a6b-96c3-746adeeb364e" config:nil];

    [SpotzPush shared].userNotificationTypes = UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge;
    
    // Override point for customization after application launch.
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Messages

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"Push registration successful with device token %@ for deviceId %@",deviceToken,[[SpotzPush shared] getDeviceId]);
    [[SpotzPush shared] appRegisteredForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"Application did register with user notification types %ld", (unsigned long)notificationSettings.types);
    [[SpotzPush shared] appRegisteredUserNotificationSettings];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[SpotzPush shared] appFailedToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    [[SpotzPush shared] appReceivedActionWithIdentifier:identifier notification:userInfo
                                       applicationState:application.applicationState completionHandler:completionHandler];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Background message");
    [[SpotzPush shared] appReceivedRemoteNotification:userInfo applicationState:application.applicationState];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [[SpotzPush shared] appReceivedRemoteNotification:userInfo applicationState:application.applicationState fetchCompletionHandler:completionHandler];
}
@end
