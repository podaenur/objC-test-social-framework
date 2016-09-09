//
//  AppDelegate.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/4/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

@import VK_ios_sdk;

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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [[GIDSignIn sharedInstance] handleURL:url
                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                               annotation:options[UIApplicationLaunchOptionsAnnotationKey]];

    [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [OKSDK openUrl:url];

    [[GIDSignIn sharedInstance] handleURL:url
                        sourceApplication:sourceApplication
                               annotation:annotation];

    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

@end
