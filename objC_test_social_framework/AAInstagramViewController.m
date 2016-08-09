//
//  AAInstagramViewController.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/8/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import <InstagramKit.h>
#import "AAInstagramViewController.h"
#import "AASharingData.h"
#import "AAConstants.h"

@interface AAInstagramViewController () <UIWebViewDelegate>

@property (nonatomic, strong) InstagramEngine *engine;
@property (nonatomic, strong) UIViewController *webViewController;
@property (nonatomic, strong) UIWebView *authorizationView;
@property (nonatomic, strong) InstagramUser *user;

//  info view
@property (weak, nonatomic) IBOutlet UIView *detailsContainer;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *profilePictureURL;
@property (weak, nonatomic) IBOutlet UILabel *bio;
@property (weak, nonatomic) IBOutlet UILabel *webSite;
@property (weak, nonatomic) IBOutlet UILabel *mediaCount;
@property (weak, nonatomic) IBOutlet UILabel *followsCount;
@property (weak, nonatomic) IBOutlet UILabel *followedByCount;
@property (weak, nonatomic) IBOutlet UITextView *detailedInfo;

//  User e-mail: NO, it is not possible in Instagram. The API do not return the user email in always.
//  http://stackoverflow.com/questions/34176597/retrieve-instagram-user-email-address

@end

@implementation AAInstagramViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.engine = [InstagramEngine sharedEngine];
    self.detailedInfo.text = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.engine.isSessionValid) {
        [self beginAuthorization];
    } else {
        [self fetchUserData];
    }
}

#pragma mark - Custom Accessors

- (UIViewController *)webViewController {
    if (!_webViewController) {
        _webViewController = [[UIViewController alloc] init];
        _webViewController.view = self.authorizationView;
    }
    
    return _webViewController;
}

- (UIWebView *)authorizationView {
    if (!_authorizationView) {
        _authorizationView = [[UIWebView alloc] init];
        _authorizationView.delegate = self;
    }
    
    return _authorizationView;
}

- (void)setUser:(InstagramUser *)user {
    _user = user;
    
    self.detailsContainer.hidden = !user;
    self.userName.text = user.username;
    self.fullName.text = user.fullName;
    self.profilePictureURL.text = user.profilePictureURL.absoluteString;
    self.bio.text = user.bio;
    self.webSite.text = user.website.absoluteString;
    self.mediaCount.text = [NSString stringWithFormat:@"%d", user.mediaCount];
    self.followsCount.text = [NSString stringWithFormat:@"%d", user.followsCount];
    self.followedByCount.text = [NSString stringWithFormat:@"%d", user.followedByCount];
}

#pragma mark - Actions

- (IBAction)onShareItPressed:(UIBarButtonItem *)sender {
    /*
     curl -F 'client_id=CLIENT-ID' \
     -F 'client_secret=CLIENT-SECRET' \
     -F 'object=user' \
     -F 'aspect=media' \
     -F 'verify_token=myVerifyToken' \
     -F 'callback_url=http://YOUR-CALLBACK/URL' \
     https://api.instagram.com/v1/subscriptions/
     */
    
//    NSDictionary *params = @{
//                             @"client_id": INSTA_CLIENT_ID,
//                             @"client_secret": INSTA_CLIENT_SECRET,
//                             @"object"
//                             };
    
//  http://stackoverflow.com/questions/11393071/how-to-share-an-image-on-instagram-in-ios
}

#pragma mark - Public

#pragma mark - Private

- (void)beginAuthorization {
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self.webViewController];
    
    [self presentViewController:navi animated:YES completion:^{
        InstagramKitLoginScope scope = ( InstagramKitLoginScopeBasic |
                                        InstagramKitLoginScopeRelationships |
                                        InstagramKitLoginScopeComments |
                                        InstagramKitLoginScopeLikes |
                                        InstagramKitLoginScopePublicContent |
                                        InstagramKitLoginScopeFollowerList );
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[self.engine authorizationURLForScope:scope]];
        [self.authorizationView loadRequest:request];
    }];
}

- (void)fetchUserData {
    [self.engine getSelfUserDetailsWithSuccess:^(InstagramUser * _Nonnull user) {
        self.user = user;
    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
        NSLog(@"Error: %@", [error description]);
    }];
}

#pragma mark - Segue
#pragma mark - Animations
#pragma mark - Protocol conformance
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSError *error;
    if ([self.engine receivedValidAccessTokenFromURL:request.URL error:&error]) {
        // success!
        [self.webViewController dismissViewControllerAnimated:YES completion:nil];
        [self fetchUserData];
    }
    return YES;
}

#pragma mark - Notifications handlers
#pragma mark - Gestures handlers
#pragma mark - KVO
#pragma mark - NSCopying
#pragma mark - NSObject

@end
