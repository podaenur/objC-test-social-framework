//
//  AALinkedInViewController.m
//  objC_test_social_framework
//
//  Created by Юрий Петухов on 22/08/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "AALinkedInViewController.h"

#import <linkedin-sdk/LISDK.h>

static NSString *const AAkLinkedInKey = @"77pyff9hua3e96";
static NSString *const AAkLinkedInSecret = @"otW7P9JCn97H0wIV";
//static NSString *const AAkLinkedInAuthorizationEndPoint = @"https://www.linkedin.com/uas/oauth2/authorization";
static NSString *const AAkLinkedInAuthorizationEndPoint = @"https://www.linkedin.com/oauth/v2/authorization";
//static NSString *const AAkLinkedInAccessTokenEndPoint = @"https://www.linkedin.com/uas/oauth2/accessToken";
static NSString *const AAkLinkedInAccessTokenEndPoint = @"https://www.linkedin.com/oauth/v2/accessToken";
static NSString *const AAkLinkedInRedirectURL = @"https://com.e-legion.linkedin.oauth/oauth";
static NSString *const AAkLinkedInOAuthHost = @"com.e-legion.linkedin.oauth";
static NSString *const AAkLinkedInGrantType = @"authorization_code";
static NSString *const AAkLinkedInProfileURL = @"https://api.linkedin.com/v1/people/~?format=json";

@interface AALinkedInViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) NSString *accessToken;

@end

@implementation AALinkedInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
//    [self requestAccessToken:@"LOL_LOL_LOL"];
}

- (IBAction)didTapAuthenticate:(UIButton *)sender {
    [self startAuthorization];
}

- (IBAction)didTapProfileInfo:(UIButton *)sender {
    
    NSString *reqStr = [NSString stringWithFormat:@"%@&%@%@", AAkLinkedInProfileURL, @"oauth2_access_token=", self.accessToken];
    
    
    NSURL *url = [NSURL URLWithString:reqStr];
//    NSURL *url = [NSURL URLWithString:[AAkLinkedInProfileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"User: %@ %@", dataDictionary[@"firstName"], dataDictionary[@"lastName"]);
            
        }
    }];
    
    [task resume];
}


- (void)startAuthorization
{
    NSString *responseType = @"code";
    NSString *redirectURL = @"https://com.e-legion.linkedin.oauth/oauth";
    // State = random string
    NSString *state = @"asdfjsiofweiuhfuyuya11532DFSDASDASFADSFDS";
    NSString *scope = @"r_basicprofile";
    
    NSString *fullURL = [NSString stringWithFormat:@"%@?response_type=%@&client_id=%@&redirect_uri=%@&state=%@&scope=%@", AAkLinkedInAuthorizationEndPoint, responseType, AAkLinkedInKey, redirectURL, state, scope];
    
    NSLog(@"AUTH STRING: %@", fullURL);
    
    NSURL *url = [NSURL URLWithString:[fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - WebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    if ([url.host isEqualToString:AAkLinkedInOAuthHost]) {
        if ([url.absoluteString rangeOfString:@"code"].location != NSNotFound) {
            NSArray *urlParts = [url.absoluteString componentsSeparatedByString:@"?"];
            NSArray *codeAndStateParts = [urlParts[1] componentsSeparatedByString:@"&"];
            NSString *code = [codeAndStateParts[0] componentsSeparatedByString:@"="][1];
            NSString *state = [codeAndStateParts[1] componentsSeparatedByString:@"="][1];
            NSLog(@"AUTHORIZATION CODE: %@", code);
            
            [self requestAccessToken:code];
        }
    }
    
    return YES;
}

- (void)requestAccessToken:(NSString *)authorizationCode {
    NSArray *parametersArray = @[[@"grant_type=" stringByAppendingString:AAkLinkedInGrantType],
                         [@"code=" stringByAppendingString:authorizationCode],
                         [@"redirect_uri=" stringByAppendingString:[AAkLinkedInRedirectURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],
                         [@"client_id=" stringByAppendingString:AAkLinkedInKey],
                         [@"client_secret=" stringByAppendingString:AAkLinkedInSecret]];
    
    NSString *requestParameters = [parametersArray componentsJoinedByString:@"&"];
    NSData *postData = [requestParameters dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSDictionary *parametersDictionary = @{@"grant_type" : AAkLinkedInGrantType,
//                                 @"code" : authorizationCode,
//                                 @"redirect_uri" : [AAkLinkedInRedirectURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                                 @"client_id" : AAkLinkedInKey,
//                                 @"client_secret" : AAkLinkedInSecret};
//    
//    NSData *postDataFromDictionary = [NSJSONSerialization dataWithJSONObject:parametersDictionary
//                                                                     options:0
//                                                                       error:nil];
//    
//    NSLog(@"ARR: %@", postData);
//    NSLog(@"DIC: %@", postDataFromDictionary);
    
    NSURL *url = [NSURL URLWithString:AAkLinkedInAccessTokenEndPoint];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = postData;
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.accessToken = dataDictionary[@"access_token"];
            NSLog(@"ACCESS TOKEN: %@", self.accessToken);
        }
    }];

    [task resume];
}



@end





















