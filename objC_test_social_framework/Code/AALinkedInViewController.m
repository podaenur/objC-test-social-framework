//
//  AALinkedInViewController.m
//  objC_test_social_framework
//
//  Created by Юрий Петухов on 22/08/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "AALinkedInViewController.h"

#import <linkedin-sdk/LISDK.h>

static NSString * const kAALinkedInProfileURL = @"https://api.linkedin.com/v1/people/~?format=json";
static NSString * const kAALinkedInShareURL = @"https://api.linkedin.com/v1/people/~/shares?format=json";
static NSString * const kAALinkedInTokenPath = @"LINKIDIN_ACCESS_TOKEN";

@interface AALinkedInViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIViewController *webViewController;

@end

@implementation AALinkedInViewController

#pragma mark - Actions

- (IBAction)didTapShare:(UIBarButtonItem *)sender {
    [self sharePost];
}

- (IBAction)didTapAuthenticate:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showWebView" sender:self];
}

- (IBAction)didTapProfileInfo:(UIButton *)sender {
    [self requestUserInfoFromServer];
}

#pragma mark - Private Methods

- (void)startAuthentication {
    self.webViewController = [UIViewController new];
    [self presentViewController:self.webViewController animated:YES completion:nil];
}

- (void)requestUserInfoFromServer {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAALinkedInTokenPath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@&%@%@", kAALinkedInProfileURL, @"oauth2_access_token=", accessToken];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"First name: %@\n Family name: %@\n Headline: %@", dataDictionary[@"firstName"], dataDictionary[@"lastName"], dataDictionary[@"headline"]);
        }
    }];
    
    [task resume];
}

- (void)sharePost {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAALinkedInTokenPath];
    
    NSDictionary *parameters = @{
                                 @"content": @{
                                         @"title": @"Developer title",
                                         @"description": @"Developer description",
                                         @"submitted-url": @"http://yandex.ru",
                                         @"submitted-image-url": @"http://i.imgur.com/27C3YIC.jpg"
                                         },
                                 @"visibility": @{
                                         @"code": @"anyone"
                                         }
                                 };
    NSError *jsonError;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON error: %@", [jsonError localizedDescription]);
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@&%@%@", kAALinkedInShareURL, @"oauth2_access_token=", accessToken];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = JSONData;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"json" forHTTPHeaderField:@"x-li-format"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                                
                                                NSString *serverMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                NSLog(@"Data: %@", serverMessage);
                                                
                                                if (statusCode == 200) {
                                                    NSLog(@"Post shared");
                                                }
                                            }];
    
    [task resume];
}

@end
