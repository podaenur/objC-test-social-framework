//
//  AAAppDelegate.h
//  objC_test_social_framework
//
//  Created by Evgeniy Akhmerov on 09/09/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, AAInstalledApplication) {
  AAFacebook      = 1 << 1,
  AATwitter       = 1 << 2,
  AAInstagram     = 1 << 3,
  AAVkontakte     = 1 << 4,
  AAOdnoklassniki = 1 << 5,
  AALinkedIn      = 1 << 6
};

@interface AAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly, assign) AAInstalledApplication appMask;

@end
