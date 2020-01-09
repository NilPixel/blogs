//
//  MMDNetworkHandle.h
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MMDResponse.h"

#define TOKENOUTDATECODE 10013

typedef NS_ENUM(NSInteger, MMDReqMethod) {
    MMDReqMethod_GET,
    MMDReqMethod_POST,
};

typedef NS_ENUM(NSUInteger, MMDNetworkStatus) {
    /** 未知网络*/
    MMDNetworkStatusUnknown,
    /** 无网络*/
    MMDNetworkStatusNotReachable,
    /** 蜂窝数据网络*/
    MMDNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    MMDNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, MMDRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    MMDRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    MMDRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, MMDResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    MMDResponseSerializerJSON,
    /** 设置响应数据为二进制格式*/
    MMDResponseSerializerHTTP,
};

/** 请求成功的Block */
typedef void(^MMDRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^MMDRequestFailed)(NSError *error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^MMDProgress)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^NetworkStatus)(MMDNetworkStatus status);

@interface MMDNetworkHandle : AFHTTPSessionManager

/**
 *  实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus;

/**
 *  一次性获取当前网络状态,有网YES,无网:NO
 */
+ (BOOL)currentNetworkStatus;

/**
 *  自动缓存请求
 *  @param reqMethod            请求方式
 *  @param URLString            请求URL
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据的回调
 *  @param callBack             回调
 *  @return 返回的对象可取消请求,调用cancel方法
 */
- (__kindof NSURLSessionTask *)call:(MMDReqMethod)reqMethod
                          URLString:(NSString *)URLString
                         parameters:(id)parameters
                      responseCache:(MMDResponseCache)responseCache
                           callBack:(void(^)(MMDResponse *response))callBack;

/**
 *  无缓存请求
 *  @param reqMethod            请求方式
 *  @param URLString            请求URL
 *  @param parameters           请求参数
 *  @param callBack             回调
 *  @return 返回的对象可取消请求,调用cancel方法
 */
- (__kindof NSURLSessionTask *)call:(MMDReqMethod)reqMethod
                          URLString:(NSString *)URLString
                         parameters:(id)parameters
                           callBack:(void(^)(MMDResponse *response))callBack;

/**
 *  上传图片文件
 *  @param URLString        请求的URL
 *  @param parameters       请求的参数
 *  @param images           上传的图片数组
 *  @param name             文件对应服务器上的字段
 *  @param fileName         文件名
 *  @param mimeType         图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress         上传进度信息
 *  @param callBack         回调
 *  @return 返回的对象可取消请求,调用cancel方法
 */
- (__kindof NSURLSessionTask *)uploadWithURLString:(NSString *)URLString
                                        parameters:(id)parameters
                                            images:(NSArray<UIImage *> *)images
                                              name:(NSString *)name
                                          fileName:(NSString *)fileName
                                          mimeType:(NSString *)mimeType
                                          progress:(MMDProgress)progress
                                          callBack:(void(^)(MMDResponse *response))callBack;

# pragma mark - 重置AFHTTPSessionManager相关属性

/**
 *  设置网络请求参数的格式:默认为JSON格式
 *
 *  @param requestSerializer PPRequestSerializerJSON(JSON格式),PPRequestSerializerHTTP(二进制格式),
 */
- (void)setRequestSerializers:(MMDRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer PPResponseSerializerJSON(JSON格式),PPResponseSerializerHTTP(二进制格式)
 */
- (void)setResponseSerializers:(MMDResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为10S
 *
 *  @param time 时长
 */
- (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
- (void)openNetworkActivityIndicator:(BOOL)open;

@end
