//
//  AAApplication.m
//  objC_test_social_framework
//
//  Created by Evgeniy Akhmerov on 12/09/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

#import "AAApplication.h"

@implementation AAApplication

- (BOOL)openURL:(NSURL*)url {
  BOOL isOpen = [super openURL:url];
  
  NSLog(@"openURL: %@", url.absoluteString);
  
  return isOpen;
}

- (BOOL)canOpenURL:(NSURL *)url {
  BOOL isCan = [super canOpenURL:url];
  
  NSLog(@"canOpenURL: %@ - %@", url.absoluteString, isCan ? @"YES" : @"NO");
  
  return isCan;
}

@end
