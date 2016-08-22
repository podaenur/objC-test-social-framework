//
//  AppDelegate.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/4/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import <ok_ios_sdk/OKSDK.h>
#import "AppDelegate.h"

#import <Google/SignIn.h>
#import <linkedin-sdk/LISDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"Started %@", NSStringFromClass([application class]));
    
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [OKSDK openUrl:url];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

#pragma mark - Google Authentication

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if ([LISDKCallbackHandler shouldHandleUrl:url]) {
        // Handle LinkedIn
        return [LISDKCallbackHandler application:app
                                         openURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
    } else {
        // Handle Google
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                          annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // Deprecated method for iOS 8 and older
    if ([LISDKCallbackHandler shouldHandleUrl:url]) {
        // Handle LinkedIn
        return [LISDKCallbackHandler application:application
                                         openURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
    } else {
        // Handle Google
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];
    }
}

@end
