//
//  MMDTestService.h
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDTestService : NSObject

+ (void)userLoginWithParams:(NSDictionary *)params callBack:(void(^)(MMDResponse *response))callBack;

+ (void)getMessageListWithParams:(NSDictionary *)params responseCache:(MMDResponseCache)responseCacheBack callBack:(void(^)(MMDResponse *response))callBack;

@end
