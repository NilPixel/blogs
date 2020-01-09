//
//  MMDResponse.h
//  YYCache+AFNetWorkingDemo
//
//  Created by Mime97 on 2016/11/15.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDResponse : NSObject

@property (nonatomic, assign) BOOL isSuccess;           //请求是否成功
@property (nonatomic, assign) NSInteger responseCode;   //请求响应码
@property (nonatomic, copy) NSString *responseContent;  //请求响应消息
@property (nonatomic, copy) id result;                  //请求返回报文

+ (MMDResponse *)shareInstance;

@end
