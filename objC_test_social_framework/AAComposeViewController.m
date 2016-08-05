//
//  AAComposeViewController.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/4/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#define SHOW_ME NSLog(@"%s", __PRETTY_FUNCTION__);

#import "AAComposeViewController.h"
#import "AAImageSelectionViewController.h"

@interface AAComposeViewController ()

@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) NSURL *sourceURL;

@end

@implementation AAComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.placeholder = @"Pass here something";
    self.charactersRemaining = @99;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor yellowColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
//    [[self navigationItem] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sample-icon"]]];
    self.navigationItem.title = @"Ololo";
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

- (NSArray<SLComposeSheetConfigurationItem *> *)configurationItems {
    return @[ [self imageItem],
              [self urlItem] ];
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

- (SLComposeSheetConfigurationItem *)imageItem {
    SLComposeSheetConfigurationItem *item = [[SLComposeSheetConfigurationItem alloc] init];
    
    item.title = @"Tap to get image";
    item.value = @"no image";

    __weak __typeof(item) weakItem = item;
    __weak __typeof(self) weakSelf = self;

    item.tapHandler = ^{
        weakItem.valuePending = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakItem.valuePending = NO;
            
            weakSelf.sourceImage = [UIImage imageNamed:@"sample"];
            weakItem.value = @"sample";
        });
    };
    
    return item;
}

- (SLComposeSheetConfigurationItem *)urlItem {
    SLComposeSheetConfigurationItem *item = [[SLComposeSheetConfigurationItem alloc] init];
    
    item.title = @"Tap to set URL";
    item.value = @"no URL";

    __weak __typeof(item) weakItem = item;
    __weak __typeof(self) weakSelf = self;
    
    item.tapHandler = ^{
        weakItem.valuePending = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakItem.valuePending = NO;
            
            weakSelf.sourceURL = [NSURL URLWithString:@"https://github.com/podaenur"];
            weakItem.value = @"github.com/podaenur";
        });
    };
    
    return item;
}

@end
