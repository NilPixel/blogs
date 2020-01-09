//
//  MMDResponse.m
//  YYCache+AFNetWorkingDemo
//
//  Created by Mime97 on 2016/11/15.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDResponse.h"

@implementation MMDResponse

static MMDResponse *newInstance = nil;
static dispatch_once_t predicate;

+ (MMDResponse *)shareInstance {
    dispatch_once(&predicate, ^{
        newInstance=[[MMDResponse alloc] init];
    });
    return newInstance;
}

@end
