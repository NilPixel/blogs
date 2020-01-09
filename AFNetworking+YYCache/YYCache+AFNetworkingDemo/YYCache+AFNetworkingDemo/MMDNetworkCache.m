//
//  MMDNetworkCache.m
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDNetworkCache.h"
#import "YYCache.h"

static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;

@implementation MMDNetworkCache

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

//生成cache key
+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters){return URL;};
    
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    
    return cacheKey;
}

@end
