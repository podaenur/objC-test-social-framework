//
//  AASharingData.m
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/8/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import "AASharingData.h"

@implementation AASharingData

+ (NSArray *)sharingPack {
    return @[ [self sharingString], [self sharingImage], [self sharingURL] ];
}

+ (NSString *)sharingString {
    return @"Hello world";
}

+ (UIImage *)sharingImage {
    return [UIImage imageNamed:@"sample"];
}

+ (NSURL *)sharingURL {
    return [NSURL URLWithString:@"https://github.com/podaenur"];
}

@end
