//
//  Bill.h
//  MJExtensionDemo
//
//  Created by Mime97 on 2016/12/7.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Bill : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Bill *bill;

@end
