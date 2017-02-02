//
//  AARootViewController.m
//  objC_test_social_framework
//
//  Created by Evgeniy Akhmerov on 09/09/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

#import "AARootViewController.h"
#import "AASharingData.h"
#import "AAAppDelegate.h"

#import <VKSdk.h>

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

@interface AARootViewController ()

@property (weak, nonatomic) IBOutlet UILabel *sharedTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *sharedURLView;
@property (weak, nonatomic) IBOutlet UIImageView *sharedImageView;

@end

@implementation AARootViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.sharedTextLabel.text = [AASharingData sharingString];
  self.sharedURLView.text = [AASharingData sharingURL].absoluteString;
  self.sharedImageView.image = [AASharingData sharingImage];
}

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

- (IBAction)onActivitySharing:(UIButton *)sender {
  
  [VKSdk initializeWithAppId:@"5580549"];
  
  if (![VKActivity vkShareExtensionEnabled]) {
  
  
  VKActivity *activityVK = [[VKActivity alloc] init];
  
  NSArray *sharing = @[ [AASharingData sharingString], [AASharingData sharingURL], [AASharingData sharingImage] ];
  UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:sharing
                                                                         applicationActivities:@[ activityVK ]];
  
    [self __presentViewController:activityVC];
  }
  
}

#pragma mark - Public

#pragma mark - Private

- (AAInstalledApplication)appMask {
  AAAppDelegate *appDel = [UIApplication sharedApplication].delegate;
  return appDel.appMask;
}

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

  if ([self appMask] & AAFacebook) {
    NSLog(@"Facebook app installed");
//    [APP openURL:STR_TO_URL(@"fb://")];
  } else {
    NSLog(@"Facebook app is NOT installed");
  }
}

- (void)twitterNetwork {
//  [self shareWithServiceType:SLServiceTypeTwitter];
  
  if ([self appMask] & AATwitter) {
    NSLog(@"Twitter app installed");
//    [APP openURL:STR_TO_URL(@"twitter://")];
  } else {
    NSLog(@"Twitter app is NOT installed");
  }
}

- (void)instagramSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAInstagramViewControllerIdentifier]];
  
  if ([self appMask] & AAInstagram) {
    NSLog(@"Instagram app installed");
//    [APP openURL:STR_TO_URL(@"instagram://")];
  } else {
    NSLog(@"Instagram app is NOT installed");
  }
}

- (void)vkontakteSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAVkontakteViewControllerIdentifier]];
  
  if ([self appMask] & AAVkontakte) {
    NSLog(@"VK app installed");
//    [APP openURL:STR_TO_URL(@"vk://")];
  } else {
    NSLog(@"VK app is NOT installed");
  }
}

- (void)odnoklassnikiSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAOdnoklassnikiViewControllerIdentifier]];
  
  if ([self appMask] & AAOdnoklassniki) {
    NSLog(@"Odnoklassniki app installed");
//    [APP openURL:STR_TO_URL(@"okauth://")];
  } else {
    NSLog(@"Odnoklassniki app is NOT installed");
  }
}

- (void)googlePlusSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAGoogleViewControllerIdentifier]];
}

- (void)linkedInSharing {
//  [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAALinkedInViewControllerIdentifier]];
  
  if ([self appMask] & AALinkedIn) {
    NSLog(@"LinkedIn app installed");
//    [APP openURL:STR_TO_URL(@"linkedin://")];
  } else {
    NSLog(@"LinkedIn app is NOT installed");
  }
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
