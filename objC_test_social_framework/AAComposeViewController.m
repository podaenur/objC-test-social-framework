//
//  AAComposeViewController.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/4/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#define SHOW_ME NSLog(@"%s", __PRETTY_FUNCTION__);

#import "AAComposeViewController.h"

@interface AAComposeViewController ()

@end

@implementation AAComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.placeholder = @"Pass here something";
    self.charactersRemaining = @99;
}

- (void)presentationAnimationDidFinish {
    [super presentationAnimationDidFinish];
}

- (void)didSelectPost {
    SHOW_ME
    
    [super didSelectPost];
    
    //  процесс постинга и все такое
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectCancel {
    SHOW_ME
    
    [super didSelectCancel];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)isContentValid {
    SHOW_ME
    
    //  вызывается каждый раз, когда что-то инсертится
    
    return [super isContentValid];
}

- (void)validateContent {
    SHOW_ME
    
    [super validateContent];
}

- (NSArray *)configurationItems {
    SHOW_ME
    
//    return [super configurationItems];
    
    SLComposeSheetConfigurationItem *item = [[SLComposeSheetConfigurationItem alloc] init];
    
    item.title = @"Tap me baby";
    item.value = @"Value? I don't saw it.";
    item.valuePending = YES;
    
    item.tapHandler = ^{
        NSLog(@"Tapped!");
    };
    
    return @[ item ];
}

- (void)reloadConfigurationItems {
    SHOW_ME
    
    [super reloadConfigurationItems];
}

- (void)pushConfigurationViewController:(UIViewController *)viewController {
    SHOW_ME
    
    [super pushConfigurationViewController:viewController];
}

- (void)popConfigurationViewController {
    SHOW_ME
    
    [super popConfigurationViewController];
}

- (UIView *)loadPreviewView {
    SHOW_ME
    
//    return [super loadPreviewView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    view.backgroundColor = [UIColor orangeColor];
    
    return view;
}

@end
