//
//  MMDLoginModel.h
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDTokenModel.h"

@interface MMDLoginModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) MMDTokenModel *userToken;

@end
