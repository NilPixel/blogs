//
//  Student.h
//  MJExtensionDemo
//
//  Created by Mime97 on 2016/12/7.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Phone.h"

@interface Student : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *nowName;
@property (nonatomic, copy) NSString *oldName;
@property (nonatomic, copy) NSString *nameChangedTime;
@property (nonatomic, strong) Phone *phone;

@end
