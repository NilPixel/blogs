//
//  MMDMessageResultModel.h
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDMessageListModel.h"

@interface MMDMessageResultModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSArray<MMDMessageListModel *> *rows;
@property (nonatomic, assign) int total;
@property (nonatomic, assign) int records;

@end
