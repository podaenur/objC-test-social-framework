//
//  AASharingData.h
//  objC_test_social_framework
//
//  Created by Евгений Ахмеров on 8/8/16.
//  Copyright © 2016 E-legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AASharingData : NSObject

+ (NSArray *)sharingPack;
+ (NSString *)sharingString;
+ (UIImage *)sharingImage;
+ (NSURL *)sharingURL;

@end
