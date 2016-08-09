//
//  UIStoryboard+AAHelper.h
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/8/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const UIStoryboardAAInstagramViewControllerIdentifier;

@interface UIStoryboard (AAHelper)

+ (UIStoryboard *)mainStoryboard;
+ (UIViewController *)controllerWithIdentifier:(NSString *)identifier;

@end
