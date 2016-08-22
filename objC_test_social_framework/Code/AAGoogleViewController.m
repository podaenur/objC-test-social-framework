//
//  AAGoogleViewController.m
//  objC_test_social_framework
//
//  Created by Юрий Петухов on 19/08/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "AAGoogleViewController.h"
#import <Google/SignIn.h>
@import SafariServices;

@interface AAGoogleViewController () <GIDSignInDelegate, GIDSignInUIDelegate, SFSafariViewControllerDelegate>

@end

@implementation AAGoogleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google service", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
}

#pragma mark - Google UIViewController

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSignOut:(UIButton *)sender {
    [[GIDSignIn sharedInstance] signOut];
}
- (IBAction)didTapShare:(UIButton *)sender {
    // Construct the Google+ share URL
    NSURLComponents* urlComponents = [[NSURLComponents alloc]
                                      initWithString:@"https://plus.google.com/share"];
    urlComponents.queryItems = @[[[NSURLQueryItem alloc]
                                  initWithName:@"url"
                                  value:@"http://yandex.ru/"]];
    NSURL* url = [urlComponents URL];
    
    if ([SFSafariViewController class]) {
        // Open the URL in SFSafariViewController (iOS 9+)
        SFSafariViewController* controller = [[SFSafariViewController alloc]
                                              initWithURL:url];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        // Open the URL in the device's browser
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)didTapDrive:(UIButton *)sender {
    NSString *driveScope = @"https://www.googleapis.com/auth/drive.readonly";
    NSArray *currentScopes = [GIDSignIn sharedInstance].scopes;
    [GIDSignIn sharedInstance].scopes = [currentScopes arrayByAddingObject:driveScope];
    
    [[GIDSignIn sharedInstance] signIn];
}


#pragma mark - GIDSignIn delegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSString *userId = user.userID;
    NSString *idToken = user.authentication.idToken;
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    
    NSLog(@"User info: %@\n %@\n %@\n %@\n %@\n %@\n", userId, idToken, fullName, givenName, familyName, email);
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    // Disconnect from app
}

@end
