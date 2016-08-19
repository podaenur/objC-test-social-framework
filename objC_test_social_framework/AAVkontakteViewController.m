//
//  AAVkontakteViewController.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/9/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

@import VK_ios_sdk;

#import "AAVkontakteViewController.h"
#import "AAConstants.h"
#import "AASharingData.h"

@interface AAVkontakteViewController () <VKSdkDelegate, VKSdkUIDelegate>

@property (nonatomic, strong) VKAuthorizationResult *authResult;

@end

@implementation AAVkontakteViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    VKSdk *sdk = [VKSdk initializeWithAppId:VK_APP_ID];
    [sdk registerDelegate:self];
    sdk.uiDelegate = self;
    
    NSArray *scope = @[ @"notify",
                        @"friends",
                        @"photos",
                        @"audio",
                        @"video",
                        @"docs",
                        @"notes",
                        @"pages",
                        @"status",
                        @"offers",
                        @"questions",
                        @"wall",
                        @"groups",
                        @"messages",
                        @"email",
                        @"notifications",
                        @"stats" ];
    [VKSdk wakeUpSession:scope completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (error) {
            NSLog(@"%@", [error description]);
        } else {
//            NSArray *states = @[ @"VKAuthorizationUnknown",
//                                 @"VKAuthorizationInitialized",
//                                 @"VKAuthorizationPending",
//                                 @"VKAuthorizationExternal",
//                                 @"VKAuthorizationSafariInApp",
//                                 @"VKAuthorizationWebview",
//                                 @"VKAuthorizationAuthorized",
//                                 @"VKAuthorizationError" ];
//            NSLog(@"%@", states[state]);
            
            if (state == VKAuthorizationInitialized) {
                [VKSdk authorize:scope];
            } else if (state == VKAuthorizationAuthorized) {
                NSLog(@"Wow. We can work");
            } else if (state == VKAuthorizationError) {
                NSLog(@"Something went wrong");
            } else {
                NSLog(@"It is possible??");
            }
        }
    }];
}

#pragma mark - Custom Accessors

#pragma mark - Actions

- (IBAction)onShareItPressed:(UIBarButtonItem *)sender {
    if (self.authResult.state == VKAuthorizationAuthorized) {
        VKShareDialogController *shareDialog = [VKShareDialogController new];
        
        shareDialog.text  = [AASharingData sharingString];
//        shareDialog.vkImages     = @[@"-10889156_348122347",@"7840938_319411365",@"-60479154_333497085"];
        shareDialog.shareLink = [[VKShareLink alloc] initWithTitle:@"Super puper link, but nobody knows" link:[NSURL URLWithString:[AASharingData sharingURL].absoluteString]];
        
        [shareDialog setCompletionHandler:^(VKShareDialogController *controller, VKShareDialogControllerResult result) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:shareDialog animated:YES completion:nil];
    } else {
        NSLog(@"You are not autorized");
    }
}

#pragma mark - Public
#pragma mark - Private
#pragma mark - Segue
#pragma mark - Animations

#pragma mark - Protocol conformance
#pragma mark VKSdkDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    self.authResult = result;
    
    VKRequest *request = [[VKApi users] get];

    [request executeWithResultBlock:^(VKResponse *response) {
        if ([response.parsedModel isKindOfClass:[VKUsersArray class]]) {
            VKUsersArray *users = response.parsedModel;
            if (users.count > 0) {
                VKUser *user = users.firstObject;
                //  ???: и что дальше
            }
        }
    } errorBlock:^(NSError *error) {
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        } else {
            NSLog(@"%@", [error description]);
        }
    }];
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

//  @optional
- (void)vkSdkAuthorizationStateUpdatedWithResult:(VKAuthorizationResult *)result {
    self.authResult = result;
}

- (void)vkSdkAccessTokenUpdated:(VKAccessToken *)newToken oldToken:(VKAccessToken *)oldToken {
    //  ???: и что? токен реадонли
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    //  ???: и что? токен реадонли
}

#pragma mark VKSdkUIDelegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self];
}

////  @optional
//- (void)vkSdkWillDismissViewController:(UIViewController *)controller {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}
//
//- (void)vkSdkDidDismissViewController:(UIViewController *)controller {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}

#pragma mark - Notifications handlers
#pragma mark - Gestures handlers
#pragma mark - KVO
#pragma mark - NSCopying
#pragma mark - NSObject

@end
