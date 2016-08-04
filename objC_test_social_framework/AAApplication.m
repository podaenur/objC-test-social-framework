//
//  AAApplication.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/4/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "AAApplication.h"

@implementation AAApplication

- (BOOL)openURL:(NSURL*)url {
    
    NSLog(@"openURL: %@", url.absoluteString);
    
    return [super openURL:url];
}

- (BOOL)canOpenURL:(NSURL *)url {
    
    NSLog(@"canOpenURL: %@", url.absoluteString);
    
    return [super canOpenURL:url];
}

@end
