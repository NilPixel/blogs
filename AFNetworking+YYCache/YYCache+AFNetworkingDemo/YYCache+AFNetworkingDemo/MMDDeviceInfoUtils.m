//
//  MMDDeviceInfoUtils.m
//  MeMeDaiSteward
//
//  Created by Mime97 on 2016/9/30.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDDeviceInfoUtils.h"
#import "sys/utsname.h"

@implementation MMDDeviceInfoUtils

+ (NSString *)getDeviceVersionInfo {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    return platform;
}

+ (NSString *)correspondVersion {
    NSString *correspondVersion = [self getDeviceVersionInfo];
    if ([correspondVersion isEqualToString:@"i386"])        return@"Simulator";
    if ([correspondVersion isEqualToString:@"x86_64"])       return @"Simulator";
    if ([correspondVersion isEqualToString:@"iPhone3,1"] || [correspondVersion isEqualToString:@"iPhone3,2"])   return@"iPhone 4";
    if ([correspondVersion isEqualToString:@"iPhone4,1"])   return@"iPhone 4S";
    if ([correspondVersion isEqualToString:@"iPhone5,1"] || [correspondVersion isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([correspondVersion isEqualToString:@"iPhone5,3"] || [correspondVersion isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([correspondVersion isEqualToString:@"iPhone6,1"] || [correspondVersion isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([correspondVersion isEqualToString:@"iPhone7,2"])   return @"iPhone 6";
    if ([correspondVersion isEqualToString:@"iPhone7,1"])   return @"iPhone 6Plus";
    if ([correspondVersion isEqualToString:@"iPhone8,1"])   return @"iPhone 6s";
    if ([correspondVersion isEqualToString:@"iPhone8,2"])   return @"iPhone 6s Plus";
    if ([correspondVersion isEqualToString:@"iPhone8,4"])   return @"iPhone SE";
    return correspondVersion;
}

@end
