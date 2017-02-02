//
//  AAAppDelegate.m
//  objC_test_social_framework
//
//  Created by Evgeniy Akhmerov on 09/09/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

#define APP [UIApplication sharedApplication]
#define STR_TO_URL(arg) [NSURL URLWithString:arg]

#import "AAAppDelegate.h"

@interface AAAppDelegate ()

@property (nonatomic, readwrite, assign) AAInstalledApplication appMask;

@end

@implementation AAAppDelegate

#pragma mark - Private

- (void)setupInstalledAppsMask {
  self.appMask = 0;
  
  if ([APP canOpenURL:STR_TO_URL(@"fb://")]) {
    self.appMask = self.appMask | AAFacebook;
  }
  
  if ([APP canOpenURL:STR_TO_URL(@"twitter://")]) {
    self.appMask = self.appMask | AATwitter;
  }
  
  if ([APP canOpenURL:STR_TO_URL(@"instagram://")]) {
    self.appMask = self.appMask | AAInstagram;
  }
  
  if ([APP canOpenURL:STR_TO_URL(@"vk://")]) {
    self.appMask = self.appMask | AAVkontakte;
  }
  
  if ([APP canOpenURL:STR_TO_URL(@"okauth://")]) {
    self.appMask = self.appMask | AAOdnoklassniki;
  }
  
  if ([APP canOpenURL:STR_TO_URL(@"linkedin://")]) {
    self.appMask = self.appMask | AALinkedIn;
  }
}

#pragma mark - Protocol conformance
#pragma mark UIApplicationDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [self setupInstalledAppsMask];
}

@end
