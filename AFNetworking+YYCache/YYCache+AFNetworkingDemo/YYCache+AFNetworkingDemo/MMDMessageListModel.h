//
//  MMDMessageListModel.h
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDMessageListModel : NSObject

@property (nonatomic, copy) NSString *msgId;
@property (nonatomic, copy) NSString *msgTitle;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, copy) NSString *msgType;
@property (nonatomic, assign) NSTimeInterval sentTime;
@property (nonatomic, copy) NSString *msgStatus;

@end
