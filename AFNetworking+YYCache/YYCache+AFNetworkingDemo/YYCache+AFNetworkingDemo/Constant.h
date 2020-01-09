//
//  Constant.h
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#ifdef DEBUG
#define MMDLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define MMDLog(...)
#endif

#define kSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
//新增字体 - 平方简体
#define FONT_PF_LIGHT(fontSize) [[[UIDevice currentDevice] systemVersion] doubleValue]>= 9.0 ? [UIFont fontWithName:@"PingFangSC-Light" size:(CGFloat)fontSize]: [UIFont systemFontOfSize:(CGFloat)fontSize]

//苹方常规体
#define FONT_PF_REGULAR(fontSize) [[[UIDevice currentDevice] systemVersion] doubleValue]>= 9.0 ? [UIFont fontWithName:@"PingFangSC-Regular" size:(CGFloat)fontSize] : [UIFont systemFontOfSize:(CGFloat)fontSize]

//中黑体
#define FONT_PF_SEMIBOLD(fontSize) [[[UIDevice currentDevice] systemVersion] doubleValue]>= 9.0 ? [UIFont fontWithName:@"PingFangSC-Semibold" size:(CGFloat)fontSize] : [UIFont boldSystemFontOfSize:(CGFloat)fontSize]

//苹方极细体
#define FONT_PF_ULTRALIGHT(fontSize) [[[UIDevice currentDevice] systemVersion] doubleValue]>= 9.0 ? [UIFont fontWithName:@"PingFangSC-UltraLight" size:(CGFloat)fontSize] :  [UIFont systemFontOfSize:(CGFloat)fontSize]

//苹方纤细体
#define FONT_PF_THIN(fontSize) [[[UIDevice currentDevice] systemVersion] doubleValue]>= 9.0 ? [UIFont fontWithName:@"PingFangSC-Thin" size:(CGFloat)fontSize]: [UIFont systemFontOfSize:(CGFloat)fontSize]

//苹方中粗体
#define FONT_PF_MEDIUM(fontSize) [[[UIDevice currentDevice] systemVersion] doubleValue]>= 9.0 ? [UIFont fontWithName:@"PingFangSC-Medium" size:(CGFloat)fontSize]: [UIFont boldSystemFontOfSize:(CGFloat)fontSize]

#define K_WINDOW         [[[UIApplication sharedApplication] delegate] window]  

#define SYS_VERSION                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define CHANNEL                             @"iOS"

#define TOKENOUTDATECODE 10013

#define ENVRIONMENT  1

#if ENVRIONMENT == 1

#define MEMEDAISTEWARD_BASE_URL @"http://99.48.58.248:8082"

#elif ENVRIONMENT == 2

#define MEMEDAISTEWARD_BASE_URL @"http://99.48.58.246:8082"

#else

#define MEMEDAISTEWARD_BASE_URL @"http://99.48.58.246:8082"

#endif


#endif /* Constant_h */
