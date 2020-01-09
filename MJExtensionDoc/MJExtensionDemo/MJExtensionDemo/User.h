//
//  User.h
//  MJExtensionDemo
//
//  Created by Mime97 on 2016/12/7.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Sex) {
    Sex_Female,
    Sex_Male,
    Sex_Unknown
};

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) NSUInteger height;
@property (nonatomic, assign) Sex sex;

@end
