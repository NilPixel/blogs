//
//  MMDTokenModel.h
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDTokenModel : NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) NSNumber *expireTime;

@end
