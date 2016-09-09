//
//  AASharingData.h
//  objC_test_social_framework
//
//  Created by Evgeniy Akhmerov on 09/09/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AASharingData : NSObject

+ (NSArray *)sharingPack;
+ (NSString *)sharingString;
+ (UIImage *)sharingImage;
+ (NSURL *)sharingURL;

@end
