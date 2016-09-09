//
//  AARootViewController.m
//  objC_test_social_framework
//
//  Created by Evgeniy Akhmerov on 09/09/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

#import "AARootViewController.h"

typedef NS_ENUM(NSUInteger, AANetworkType) {
  AANetworkTypeActivity = 0,
  AANetworkTypeFacebook = 1,
  AANetworkTypeTwitter = 2,
  AANetworkTypeInstagram = 3,
  AANetworkTypeVkontakte = 4,
  AANetworkTypeOdnoklassniki = 5,
  AANetworkTypeGooglePlus = 6,
  AANetworkTypeLinkedIn = 7,
};

@implementation AARootViewController

#pragma mark - Life cycle
#pragma mark - Custom Accessors

#pragma mark - Actions

- (IBAction)onSelectNetwork:(UISegmentedControl *)sender {
  switch (sender.selectedSegmentIndex) {
    case AANetworkTypeFacebook: [self facebookNetwork]; break;
    case AANetworkTypeActivity: [self activitySharing]; break;
    case AANetworkTypeTwitter: [self twitterNetwork]; break;
    case AANetworkTypeInstagram: [self instagramSharing]; break;
    case AANetworkTypeVkontakte: [self vkontakteSharing]; break;
    case AANetworkTypeOdnoklassniki: [self odnoklassnikiSharing]; break;
    case AANetworkTypeGooglePlus: [self googlePlusSharing]; break;
    case AANetworkTypeLinkedIn: [self linkedInSharing]; break;
    default: break;
  }
}

#pragma mark - Public

#pragma mark - Private

- (void)__pushViewController:(UIViewController *)vc {
  if ([vc isKindOfClass:[UINavigationController class]] && ((UINavigationController *)vc).topViewController) {
    [self.navigationController pushViewController:((UINavigationController *)vc).topViewController animated:YES];
  } else {
    [self.navigationController pushViewController:vc animated:YES];
  }
}

- (void)__presentViewController:(UIViewController *)vc {
  if ([vc isKindOfClass:[UINavigationController class]] && ((UINavigationController *)vc).topViewController) {
    [self presentViewController:((UINavigationController *)vc).topViewController animated:YES completion:nil];
  } else {
    [self presentViewController:
     vc animated:YES completion:nil];
  }
}

- (void)activitySharing {
//  [self __presentViewController:activity];
}

- (void)facebookNetwork {
//  [self shareWithServiceType:SLServiceTypeFacebook];
}

- (void)twitterNetwork {
//  [self shareWithServiceType:SLServiceTypeTwitter];
}

- (void)instagramSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAInstagramViewControllerIdentifier]];
}

- (void)vkontakteSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAVkontakteViewControllerIdentifier]];
}

- (void)odnoklassnikiSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAOdnoklassnikiViewControllerIdentifier]];
}

- (void)googlePlusSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAGoogleViewControllerIdentifier]];
}

- (void)linkedInSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAALinkedInViewControllerIdentifier]];
}

#pragma mark - Segue
#pragma mark - Animations
#pragma mark - Protocol conformance
#pragma mark - Notifications handlers
#pragma mark - Gestures handlers
#pragma mark - KVO
#pragma mark - NSCopying
#pragma mark - NSObject

@end
