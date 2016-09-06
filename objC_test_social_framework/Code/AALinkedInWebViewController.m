//
//  AALinkedInWebViewController.m
//  objC_test_social_framework
//
//  Created by Юрий Петухов on 23/08/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "AALinkedInWebViewController.h"

static NSString * const kAALinkedInKey = @"77pyff9hua3e96";
static NSString * const kAALinkedInSecret = @"otW7P9JCn97H0wIV";
static NSString * const kAALinkedInAuthorizationEndPoint = @"https://www.linkedin.com/oauth/v2/authorization";
static NSString * const kAALinkedInAccessTokenEndPoint = @"https://www.linkedin.com/oauth/v2/accessToken";
static NSString * const kAALinkedInRedirectURL = @"https://com.e-legion.linkedin.oauth/oauth";
static NSString * const kAALinkedInOAuthHost = @"com.e-legion.linkedin.oauth";
static NSString * const kAALinkedInGrantType = @"authorization_code";
static NSString * const kAALinkedInTokenPath = @"LINKIDIN_ACCESS_TOKEN";

@interface AALinkedInWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AALinkedInWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    [self startAuthorization];
}

- (void)startAuthorization
{
    NSString *responseType = @"code";
    NSString *redirectURL = @"https://com.e-legion.linkedin.oauth/oauth";
    // State = random string
    NSString *state = @"asdfjsiofweiuhfuyuya11532DFSDASDASFADSFDS";
    NSString *scope = @"r_basicprofile+r_emailaddress+w_share"; // Get acces to profile, e-mail and sharing
    
    NSString *fullURL = [NSString stringWithFormat:@"%@?response_type=%@&client_id=%@&redirect_uri=%@&state=%@&scope=%@", kAALinkedInAuthorizationEndPoint, responseType, kAALinkedInKey, redirectURL, state, scope];
    
    NSLog(@"Authorizations string: %@", fullURL);
    
    NSURL *url = [NSURL URLWithString:[fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - WebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    if ([url.host isEqualToString:kAALinkedInOAuthHost]) {
        if ([url.absoluteString rangeOfString:@"code"].location != NSNotFound) {
            NSArray *urlParts = [url.absoluteString componentsSeparatedByString:@"?"];
            NSArray *codeAndStateParts = [urlParts[1] componentsSeparatedByString:@"&"];
            NSString *code = [codeAndStateParts[0] componentsSeparatedByString:@"="][1];
            NSString *state = [codeAndStateParts[1] componentsSeparatedByString:@"="][1];
            NSLog(@"Authorization code: %@", code);
            
            [self requestAccessToken:code];
        }
    }
    
    return YES;
}

- (void)requestAccessToken:(NSString *)authorizationCode {
    NSArray *parametersArray = @[[@"grant_type=" stringByAppendingString:kAALinkedInGrantType],
                                 [@"code=" stringByAppendingString:authorizationCode],
                                 [@"redirect_uri=" stringByAppendingString:[kAALinkedInRedirectURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],
                                 [@"client_id=" stringByAppendingString:kAALinkedInKey],
                                 [@"client_secret=" stringByAppendingString:kAALinkedInSecret]];
    
    NSString *requestParameters = [parametersArray componentsJoinedByString:@"&"];
    NSData *postData = [requestParameters dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:kAALinkedInAccessTokenEndPoint];
    
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
            
            NSString *accessToken = dataDictionary[@"access_token"];
            
            if (accessToken) {
                NSLog(@"Access token: %@", accessToken);
                [self saveToken:accessToken];
                
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }
    }];
    
    [task resume];
}

- (void)saveToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kAALinkedInTokenPath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
