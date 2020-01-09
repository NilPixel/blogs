//
//  MMDMD5Utils.m
//  MeMeDaiSteward
//
//  Created by Mime97 on 16/5/23.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDMD5Utils.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation MMDMD5Utils

+ (NSString *)encrypt:(NSString *)str {
    if (str == nil || [str length] == 0) {
        return  nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr) , result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
