//
//  AAViewController.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/4/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

@import Social;
#import "AAViewController.h"
#import "AAComposeViewController.h"
#import "UIStoryboard+AAHelper.h"
#import "AASharingData.h"

typedef NS_ENUM(NSUInteger, AAEntityType) {
    AAEntityTypeString = 0,
    AAEntityTypeImage = 1,
    AAEntityTypeURL = 2,
};

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

@interface AAViewController ()

@property (nonatomic, copy) void (^sharingCompletionHandler)(SLComposeViewControllerResult result);
@property (nonatomic, copy) void (^activityCompletionHandler)(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError);

@end

@implementation AAViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharingCompletionHandler = ^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled: NSLog(@"Sharing canceled..."); break;
            case SLComposeViewControllerResultDone: NSLog(@"Sharing complete."); break;
        }
    };
    
    self.activityCompletionHandler = ^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
        NSLog(@"Type: %@", activityType);
        NSLog(@"%@", (completed) ? @"Complited" : @"Failed");
        
        NSLog(@"Items: %@", [returnedItems description]);
        
        if (activityError) {
            NSLog(@"Error: %@", [activityError description]);
        }
        
        /*
         Type: com.apple.UIKit.activity.PostToFacebook
         Complited
         Items: (null)
         */
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook
//                                            requestMethod:SLRequestMethodGET
//                                                      URL:<#(NSURL *)#>
//                                               parameters:<#(NSDictionary *)#>];
    
    SLComposeSheetConfigurationItem *item = [[SLComposeSheetConfigurationItem alloc] init];
    item.title = @"Hello world title";
    item.value = @"Some value I don't know about";
    item.valuePending = YES;
//    item.tapHandler =
}

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

- (void)shareWithServiceType:(NSString *)serviceType {
    BOOL canShare = NO;
    
    if ([serviceType isEqualToString:SLServiceTypeFacebook]) {
        canShare = YES;
    } else if ([serviceType isEqualToString:SLServiceTypeTwitter]) {
        canShare = YES;
    }
    
    if (canShare) {
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        vc.completionHandler = self.sharingCompletionHandler;
        
        NSArray *pack = [AASharingData sharingPack];
        [vc setInitialText:pack[AAEntityTypeString]];
        [vc addImage:pack[AAEntityTypeImage]];
        [vc addURL:pack[AAEntityTypeURL]];
        
        [self __presentViewController:vc];
    } else {
        NSLog(@"ERROR: Wrong service type");
    }
}

- (void)activitySharing {
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:[AASharingData sharingPack] applicationActivities:nil];
    
    activity.completionWithItemsHandler = self.activityCompletionHandler;
    
    [self __presentViewController:activity];
}

- (void)facebookNetwork {
    [self shareWithServiceType:SLServiceTypeFacebook];
}

- (void)twitterNetwork {
    [self shareWithServiceType:SLServiceTypeTwitter];
}

- (void)instagramSharing {
    [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAInstagramViewControllerIdentifier]];
}

- (void)vkontakteSharing {
    [self __pushViewController:[UIStoryboard controllerWithIdentifier:UIStoryboardAAVkontakteViewControllerIdentifier]];
}

- (void)odnoklassnikiSharing {
    //  void
}

- (void)googlePlusSharing {
    //  void
}

- (void)linkedInSharing {
    //  void
}

#pragma mark - Actions

- (void)onCancel:(id)sender {
    
}

- (IBAction)onSelectNetwork:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case AANetworkTypeFacebook:
            [self facebookNetwork];
            break;
        case AANetworkTypeActivity:
            [self activitySharing];
            break;
        case AANetworkTypeTwitter:
            [self twitterNetwork];
            break;
        case AANetworkTypeInstagram:
            [self instagramSharing];
            break;
        case AANetworkTypeVkontakte:
            [self vkontakteSharing];
            break;
        case AANetworkTypeOdnoklassniki:
            [self odnoklassnikiSharing];
            break;
        case AANetworkTypeGooglePlus:
            [self googlePlusSharing];
            break;
        case AANetworkTypeLinkedIn:
            [self linkedInSharing];
            break;
        default:
            break;
    }
}

- (IBAction)onCustomComposePressed:(UIButton *)sender {
    AAComposeViewController *vc = [[AAComposeViewController alloc] init];
    [self __presentViewController:vc];    
}

@end
