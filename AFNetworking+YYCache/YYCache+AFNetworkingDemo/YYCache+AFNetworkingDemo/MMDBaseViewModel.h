//
//  MMDBaseViewModel.h
//  MeMeDaiSteward
//
//  Created by Mime97 on 16/8/11.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDBaseViewModel : NSObject

//解析验证筛选数据并处理逻辑
- (NSDictionary *)getFilterDataWithResponseResult:(NSArray *)result isCouponList:(BOOL)isCouponList;

@end

//Http request callback blocks
typedef void (^VoidBlock)(void);
typedef void (^StringBlock)(NSString *info, NSError *error);
typedef void (^BoolBlock)(BOOL flag, NSError *error);
//typedef void (^ModelBlock)(MMDModel *model, NSError *error);
typedef void (^ArrayBlock)(NSMutableArray *models, NSError *error);
typedef void (^DictionaryBlock)(NSMutableDictionary *infoDict, NSError *error);
typedef void (^IntegerBlock)(NSInteger index, NSError *error);
typedef void (^ErrorBlock)(NSError *error);
