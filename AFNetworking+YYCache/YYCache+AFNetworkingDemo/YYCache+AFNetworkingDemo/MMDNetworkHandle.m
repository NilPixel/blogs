//
//  MMDNetworkHandle.m
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDNetworkHandle.h"
#import "MMDNetworkCache.h"

static BOOL _isNetwork;

@implementation MMDNetworkHandle

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
        NSLog(@"<<=============initWithBaseURL===============>>");
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];

        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"platform_version"];
    
        [self.requestSerializer setValue:[MMDDeviceInfoUtils correspondVersion] forHTTPHeaderField:@"phone_info"];
        [self.requestSerializer setValue:SYS_VERSION forHTTPHeaderField:@"sysVersion"];
        [self.requestSerializer setValue:CHANNEL forHTTPHeaderField:@"channel"];
        NSString *uuidString = @"07ABCB92-1867-48BD-8463-1FEB7796E1";
        MMDLog(@"uuidString%@",uuidString);
        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"uuid"];
        [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.requestSerializer.timeoutInterval = 10.f;
        [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSLog(@"=======HTTP request platform_version: %@", [[UIDevice currentDevice] systemVersion]);
        //打开状态栏的等待菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    return self;
}

+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(MMDNetworkStatusUnknown) : nil;
                    _isNetwork = NO;
                    MMDLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(MMDNetworkStatusNotReachable) : nil;
                    _isNetwork = NO;
                    MMDLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(MMDNetworkStatusReachableViaWWAN) : nil;
                    _isNetwork = YES;
                    MMDLog(@"蜂窝数据网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(MMDNetworkStatusReachableViaWiFi) : nil;
                    _isNetwork = YES;
                    MMDLog(@"WIFI");
                    break;
            }
        }];
        [manager startMonitoring];
    });
}

+ (BOOL)currentNetworkStatus {
    return _isNetwork;
}

#pragma mark - GET/POST无缓存请求
- (NSURLSessionTask *)call:(MMDReqMethod)reqMethod URLString:(NSString *)URLString parameters:(id)parameters callBack:(void (^)(MMDResponse *))callBack {
    return [self call:reqMethod URLString:URLString parameters:parameters responseCache:nil callBack:callBack];
}

#pragma mark - GET/POST自动缓存请求
- (NSURLSessionTask *)call:(MMDReqMethod)reqMethod URLString:(NSString *)URLString parameters:(id)parameters responseCache:(MMDResponseCache)responseCache callBack:(void (^)(MMDResponse *))callBack {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"] ? [[NSUserDefaults standardUserDefaults] valueForKey:@"token"] : @"";
    MMDLog(@"============accessToken===========%@=============",accessToken);
    [self.requestSerializer setValue:accessToken forHTTPHeaderField:@"mmTicket"];
    [self.requestSerializer setValue:[MMDDateUtils getTimestamp] forHTTPHeaderField:@"MPTSP"];//时间戳(毫秒)
    [self.requestSerializer setValue:@"" forHTTPHeaderField:@"clientid"];
    switch (reqMethod) {
        case MMDReqMethod_GET:{
            //读取缓存
            responseCache ? responseCache([MMDNetworkCache httpCacheForURL:URLString parameters:parameters]) : nil;
            NSURLSessionDataTask *dataTask = [self GET:URLString
                                            parameters:parameters
                                              progress:nil
                                               success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                                   
                       [self handleResponse:responseObject error:nil callBack:callBack];
                       //对数据进行异步缓存
                       responseCache ? [MMDNetworkCache setHttpCache:responseObject URL:URLString parameters:parameters] : nil;
                                                   
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                       [self handleResponse:nil error:error callBack:callBack];
                                               }];
            return dataTask;
            break;
        }
        case MMDReqMethod_POST:{
            //读取缓存
            responseCache ? responseCache([MMDNetworkCache httpCacheForURL:URLString parameters:parameters]) : nil;
            NSURLSessionDataTask *dataTask = [self POST:URLString
                                             parameters:parameters progress:nil
                                                success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                                    
                        [self handleResponse:responseObject error:nil callBack:callBack];
                        //对数据进行异步缓存
                        responseCache ? [MMDNetworkCache setHttpCache:responseObject URL:URLString parameters:parameters] : nil;
                                                    
                                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self handleResponse:nil error:error callBack:callBack];
                                                }];
            return dataTask;
            break;
        }
        default:
            break;
    }
    return nil;
}

#pragma mark - 上传图片
- (NSURLSessionTask *)uploadWithURLString:(NSString *)URLString
                               parameters:(id)parameters
                                   images:(NSArray<UIImage *> *)images
                                     name:(NSString *)name
                                 fileName:(NSString *)fileName
                                 mimeType:(NSString *)mimeType
                                 progress:(MMDProgress)progress
                                 callBack:(void (^)(MMDResponse *))callBack {
    return [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"]
                                    mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]
             ];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject error:nil callBack:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponse:nil error:error callBack:callBack];
    }];
    
}

- (void)handleResponse:(id)responseObject error:(NSError*)error callBack:(void(^)(MMDResponse *result))callBack {
    MMDResponse *response = [MMDResponse new];
    if (error) {
        NSLog(@"========HTTP error: %@", error);
        if ([error code] == NSURLErrorNotConnectedToInternet) {
            response.responseCode = 1020;
            response.responseContent = @"网络异常，请检查您的网络设置！";
        } else if([error code] == NSURLErrorTimedOut || [error code] == NSURLErrorCannotConnectToHost) {
            response.responseCode = [error code];
            response.responseContent = @"与服务器通讯失败，请稍后重试！";
        } else {
            response.responseCode = [error code];
            response.responseContent = @"与服务器通讯失败，请稍后重试！";
        }
        response.isSuccess = NO;
    } else {
        NSInteger respCode = [[responseObject objectForKey:@"code"]integerValue];
        NSString *respDesc =[responseObject objectForKey:@"desc"];
        response.isSuccess = NO;
        if (respCode == 0) {
            response.isSuccess = YES;
        } else if (respCode == TOKENOUTDATECODE) {
            //            if ([MMDUserModel shareInstance].isTokenOut) {
            //                [[NSNotificationCenter defaultCenter] postNotificationName:tokenOutOfDateString object:nil];
            //                [MMDUserModel shareInstance].isTokenOut = NO;
            //            }
        } else if (respCode == 1 || respCode == 2 || respCode == 3) {
            response.responseContent = @"网络错误，请稍后再试！";
            respDesc = @"网络错误，请稍后再试！";
        }
        response.responseCode = respCode;
        response.responseContent = respDesc;
        response.result = responseObject;
        NSLog(@"=======HTTP respCode: %ld , respDesc: %@", (long)respCode, respDesc);
        NSLog(@"=======HTTP result: %@", responseObject);
    }
    if (callBack) {
        callBack(response);
    }
}

#pragma mark - 设置AFHTTPSessionManager相关属性
- (void)setRequestSerializers:(MMDRequestSerializer)requestSerializer {
    self.requestSerializer = requestSerializer == MMDRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

- (void)setResponseSerializers:(MMDResponseSerializer)responseSerializer {
    self.responseSerializer = responseSerializer == MMDResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

- (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    self.requestSerializer.timeoutInterval = time;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

@end
