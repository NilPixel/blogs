//
//  MMDHttpHandle.m
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDHttpHandle.h"

@implementation MMDHttpHandle

static MMDHttpHandle *newInstance;
static dispatch_once_t predicate;

+ (instancetype)shareInstance {
    dispatch_once(&predicate, ^{
        newInstance = [[MMDHttpHandle alloc]initWithBaseURL:[NSURL URLWithString:[MEMEDAISTEWARD_BASE_URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    });
    return newInstance;
}

@end
