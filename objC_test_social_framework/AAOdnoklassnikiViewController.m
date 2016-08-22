//
//  AAOdnoklassnikiViewController.m
//  objC_test_social_framework
//
//  Created by Николай Кагала on 22/08/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import <ok_ios_sdk/OKSDK.h>
#import "AAOdnoklassnikiViewController.h"
#import "AAConstants.h"
#import "AASharingData.h"

@interface AAOdnoklassnikiViewController ()

@property (weak, nonatomic) UITextView *infoTextView;

@end

@implementation AAOdnoklassnikiViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSDK];
    [self authorize];
}

- (void)viewDidLayoutSubviews {
    if (!self.infoTextView){
        UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:textView];
        self.infoTextView = textView;
    }
}

- (void)authorize {
    [OKSDK authorizeWithPermissions:@[@"VALUABLE_ACCESS",@"LONG_ACCESS_TOKEN"]
                            success:^(id data) {
                                NSLog(@"Authorized: %@", data);
                                [self getCurrentUser];
                            }
                              error:^(NSError *error) {
                                  NSLog(@"Authorization error: %@", error);
                              }
     ];
}

- (void)configureSDK {
    OKSDKInitSettings *settings = [[OKSDKInitSettings alloc] init];
    settings.appKey = OK_PUBLIC_KEY;
    settings.appId = OK_APP_ID;
    settings.controllerHandler = ^{
        return self;
    };
    [OKSDK initWithSettings: settings];
}

- (IBAction)shareItAction:(id)sender {
    
    NSDictionary *string = @{@"type": @"text",
                             @"text": [AASharingData sharingString]};
    
    NSDictionary *link = @{@"type": @"link",
                           @"url": [AASharingData sharingURL].absoluteString};
    
    NSArray *jsonArray = @[string, link];
    
    id data = [NSJSONSerialization dataWithJSONObject:@{@"media":jsonArray} options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [OKSDK showWidget:@"WidgetMediatopicPost" arguments:@{@"st.attachment":jsonString} options:@{@"st.utext":@"on"}
              success:^(NSDictionary *data) {
                  NSLog(@"Widget success: %@", data);
              }
                error:^(NSError *error) {
                    NSLog(@"Widget error: %@", error);
                }
     ];
}

- (void)getCurrentUser {
    [OKSDK invokeMethod:@"users.getCurrentUser" arguments:@{} success:^(id data) {
        NSLog(@"User info: %@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.infoTextView.text = [data description];
        });
        
    } error:^(NSError *error) {
        NSLog(@"Error getting user info: %@", error);
    }];
}

@end
