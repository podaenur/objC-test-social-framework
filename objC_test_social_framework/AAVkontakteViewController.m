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
  
//  NSArray *scope = @[ @"nickname", @"screen_name", @"sex", @"bdate (birthdate)", @"city", @"country", @"timezone", @"photo", @"photo_medium", @"photo_big", @"has_mobile", @"contacts", @"education", @"online", @"counters", @"relation", @"last_seen", @"activity", @"can_write_private_message", @"can_see_all_posts", @"can_post", @"universities"];
    
//    NSArray *scope = @[ @"offline" ];
  
//    [VKSdk wakeUpSession:scope completeBlock:^(VKAuthorizationState state, NSError *error) {
//        if (error) {
//            NSLog(@"%@", [error description]);
//        } else {
////            NSArray *states = @[ @"VKAuthorizationUnknown",
////                                 @"VKAuthorizationInitialized",
////                                 @"VKAuthorizationPending",
////                                 @"VKAuthorizationExternal",
////                                 @"VKAuthorizationSafariInApp",
////                                 @"VKAuthorizationWebview",
////                                 @"VKAuthorizationAuthorized",
////                                 @"VKAuthorizationError" ];
////            NSLog(@"%@", states[state]);
//            
//            if (state == VKAuthorizationInitialized) {
//                [VKSdk authorize:scope];
//            } else if (state == VKAuthorizationAuthorized) {
//                NSLog(@"Wow. We can work");
//            } else if (state == VKAuthorizationError) {
//                NSLog(@"Something went wrong");
//            } else {
//                NSLog(@"It is possible??");
//            }
//        }
//    }];
    
    [VKSdk authorize:scope withOptions:VKAuthorizationOptionsDisableSafariController];
}

#pragma mark - Custom Accessors

#pragma mark - Actions

- (IBAction)onShareItPressed:(UIBarButtonItem *)sender {
    if (self.authResult.state == VKAuthorizationAuthorized) {
        VKShareDialogController *shareDialog = [VKShareDialogController new];
        
        shareDialog.text  = [AASharingData sharingString];
//        shareDialog.vkImages     = @[@"-10889156_348122347",@"7840938_319411365",@"-60479154_333497085"];
        shareDialog.vkImages = @[ @"41733415_291014509" ];  //  картинка, уже сохраненная в каком-либо альбоме
        shareDialog.shareLink = [[VKShareLink alloc] initWithTitle:@"Super puper link, but nobody knows" link:[NSURL URLWithString:[AASharingData sharingURL].absoluteString]];
        
        [shareDialog setCompletionHandler:^(VKShareDialogController *controller, VKShareDialogControllerResult result) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:shareDialog animated:YES completion:nil];
    } else {
        NSArray *states = @[ @"VKAuthorizationUnknown",
                             @"VKAuthorizationInitialized",
                             @"VKAuthorizationPending",
                             @"VKAuthorizationExternal",
                             @"VKAuthorizationSafariInApp",
                             @"VKAuthorizationWebview",
                             @"VKAuthorizationAuthorized",
                             @"VKAuthorizationError" ];

        NSLog(@"You are not autorized (%@)", states[self.authResult.state]);
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
    
    NSArray *fields = @[ @"id,first_name",
                        @"last_name,sex",
                        @"bdate",
                        @"city",
                        @"country",
                        @"photo_50",
                        @"photo_100",
                        @"photo_200_orig",
                        @"photo_200",
                        @"photo_400_orig",
                        @"photo_max",
                        @"photo_max_orig",
                        @"online",
                        @"online_mobile",
                        @"lists",
                        @"domain",
                        @"has_mobile",
                        @"contacts",
                        @"connections",
                        @"site",
                        @"education",
                        @"universities",
                        @"schools",
                        @"can_post",
                        @"can_see_all_posts",
                        @"can_see_audio",
                        @"can_write_private_message",
                        @"status",
                        @"last_seen",
                        @"common_count",
                        @"relation",
                        @"relatives",
                        @"counters" ];
    
    [[[VKApi users] get:@{ VK_API_FIELDS : [fields componentsJoinedByString:@","] }]
     executeWithResultBlock:^(VKResponse *response) {
         VKUser *user = ((VKUsersArray*)response.parsedModel).firstObject;
         //  ???: и что дальше
         NSLog(@"%@", user.fields);
         /*
          {
          bdate = "1.1.1901";
          "can_post" = 1;
          "can_see_all_posts" = 1;
          "can_see_audio" = 1;
          "can_write_private_message" = 1;
          city =     {
          id = 2;
          title = "\U0421\U0430\U043d\U043a\U0442-\U041f\U0435\U0442\U0435\U0440\U0431\U0443\U0440\U0433";
          };
          "common_count" = 3;
          counters =     {
          albums = 1;
          audios = 642;
          followers = 65;
          friends = 3;
          gifts = 14;
          groups = 23;
          notes = 33;
          "online_friends" = 0;
          pages = 14;
          photos = 7;
          subscriptions = 0;
          "user_photos" = 31;
          "user_videos" = 1;
          videos = 129;
          };
          country =     {
          id = 1;
          title = "\U0420\U043e\U0441\U0441\U0438\U044f";
          };
          domain = spiritofcorvette;
          faculty = 0;
          "faculty_name" = "";
          "first_name" = "\U0416\U0435\U043d\U0435\U0447\U043a\U0430";
          graduation = 0;
          "has_mobile" = 1;
          "home_phone" = "";
          id = 41733415;
          "last_name" = "\U0410\U0445\U043c\U0435\U0440\U043e\U0432";
          "last_seen" =     {
          platform = 7;
          time = 1473085399;
          };
          "mobile_phone" = "available upon request";
          online = 1;
          "photo_100" = "https://pp.vk.me/c575/u41733415/d_850dd8b2.jpg";
          "photo_200_orig" = "https://pp.vk.me/c575/u41733415/a_a532c37d.jpg";
          "photo_50" = "https://pp.vk.me/c575/u41733415/e_bbbeb6ca.jpg";
          "photo_max" = "https://pp.vk.me/c575/u41733415/d_850dd8b2.jpg";
          "photo_max_orig" = "https://pp.vk.me/c575/u41733415/a_a532c37d.jpg";
          relation = 0;
          relatives =     (
          );
          schools =     (
          );
          sex = 2;
          site = "http://www.linkedin.com/pub/eugeny-akhmerov/96/686/6a   https://angel.co/evgeniy-akhmerov";
          status = "\U6210\U529f\U8005";
          universities =     (
          );
          university = 0;
          "university_name" = "";
          }          */
         
     } errorBlock:^(NSError *error) {
         NSLog(@"Error: %@", error);
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
