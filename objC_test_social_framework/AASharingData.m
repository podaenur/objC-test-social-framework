//
//  AASharingData.m
//  objC_test_social_framework
//
//  Created by Evgeniy Akhmerov on 09/09/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

#import "AASharingData.h"

@implementation AASharingData

+ (NSArray *)sharingPack {
  return @[ [self sharingString], [self sharingImage], [self sharingURL] ];
}

+ (NSString *)sharingString {
  return @"Look at this beautiful cyborg woman. Is it that what will come true?";
}

+ (UIImage *)sharingImage {
  return [UIImage imageNamed:@"cyborg"];
}

+ (NSURL *)sharingURL {
  return [NSURL URLWithString:@"https://github.com/podaenur"];
}

@end
