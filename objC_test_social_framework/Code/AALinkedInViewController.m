//
//  AALinkedInViewController.m
//  objC_test_social_framework
//
//  Created by Юрий Петухов on 22/08/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "AALinkedInViewController.h"

#import <linkedin-sdk/LISDK.h>

static NSString *const AAkLinkedInProfileURL = @"https://api.linkedin.com/v1/people/~?format=json";

@interface AALinkedInViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIViewController *webViewController;
@property (nonatomic, copy) NSString *accessToken;

@end

@implementation AALinkedInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)didTapAuthenticate:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showWebView" sender:self];
}

- (void)startAuthentication {
    self.webViewController = [UIViewController new];
    [self presentViewController:self.webViewController animated:YES completion:nil];
}

- (IBAction)didTapProfileInfo:(UIButton *)sender {
    
    NSString *reqStr = [NSString stringWithFormat:@"%@&%@%@", AAkLinkedInProfileURL, @"oauth2_access_token=", self.accessToken];
    
    NSURL *url = [NSURL URLWithString:reqStr];
    
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

@end
