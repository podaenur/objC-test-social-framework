//
//  UIStoryboard+AAHelper.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/8/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "UIStoryboard+AAHelper.h"

NSString *const UIStoryboardAAInstagramViewControllerIdentifier = @"AAInstagramViewController";
NSString *const UIStoryboardAAVkontakteViewControllerIdentifier = @"AAVkontakteViewController";
NSString *const UIStoryboardAAOdnoklassnikiViewControllerIdentifier = @"AAOdnoklassnikiViewController";
NSString *const UIStoryboardAAGoogleViewControllerIdentifier = @"AAGoogleViewController";
NSString *const UIStoryboardAALinkedInViewControllerIdentifier = @"AALinkedInViewController";
//NSString *const UIStoryboard<#name#>Identifier = @"<#name#>";

NSString *const kUIStoryboardMainName = @"Main";

@implementation UIStoryboard (AAHelper)

+ (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:kUIStoryboardMainName bundle:nil];
}

+ (UIViewController *)controllerWithIdentifier:(NSString *)identifier {
    return [[self mainStoryboard] instantiateViewControllerWithIdentifier:identifier];
}

@end
