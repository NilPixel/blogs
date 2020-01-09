//
//  MMDTestService.m
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDTestService.h"
#import "MMDHttpHandle.h"
#import "MMDMessageResultModel.h"
#import "MMDLoginModel.h"

@implementation MMDTestService

+ (void)userLoginWithParams:(NSDictionary *)params callBack:(void (^)(MMDResponse *))callBack {
    [[MMDHttpHandle shareInstance] call:MMDReqMethod_POST URLString:@"api/user/app/login/11" parameters:params callBack:^(MMDResponse *response) {
        if (response.isSuccess) {
            
        }
        if (callBack) {
            callBack(response);
        }
    }];
}

+ (void)getMessageListWithParams:(NSDictionary *)params responseCache:(MMDResponseCache)responseCacheBack callBack:(void (^)(MMDResponse *))callBack {
    [[MMDHttpHandle shareInstance] call:MMDReqMethod_POST URLString:@"api/messagePush/getPushedMessageListForMobile" parameters:params responseCache:^(id responseCache) {
        if (![responseCache isMemberOfClass:[NSNull class]]) {
            MMDMessageResultModel *resultModel = [MMDMessageResultModel mj_objectWithKeyValues:responseCache];
            responseCache = resultModel.rows;
        } else {
            responseCache = [NSMutableArray array];
        }
        if (responseCacheBack) {
            responseCacheBack(responseCache);
        }
    } callBack:^(MMDResponse *response) {
        if (response.isSuccess) {
            if (![response.result isMemberOfClass:[NSNull class]]) {
                MMDMessageResultModel *resultModel = [MMDMessageResultModel mj_objectWithKeyValues:response.result];
                response.result = resultModel.rows;
            } else {
                response.result = [NSMutableArray array];
            }
        }
        if (callBack) {
            callBack(response);
        }
    }];
}

@end
