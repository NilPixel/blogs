//
//  MMDBaseViewModel.m
//  MeMeDaiSteward
//
//  Created by Mime97 on 16/8/11.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDBaseViewModel.h"
//#import "MMDStoreAndAssistantModel.h"

@implementation MMDBaseViewModel

//- (NSDictionary *)getFilterDataWithResponseResult:(NSArray *)result isCouponList:(BOOL)isCouponList {
//    NSMutableArray *storeAndAssistantModelArr = [NSMutableArray array];
//    NSMutableArray *storeListArr = [NSMutableArray array];
//    NSMutableArray *allAssistantNameArr = [NSMutableArray array];
//    NSMutableArray *allAssistantIDArr = [NSMutableArray array];
//    //将整个门店和营业员模型从解析的数据中的大数组中取出来，并重新存储到storeAndAssistantModelArr数组中
//    for (int i = 0; i < result.count; i++) {
//        MMDStoreAndAssistantModel *storeAndAssistantModel = [[MMDStoreAndAssistantModel alloc] initWithDic:result[i]];
//        [storeAndAssistantModelArr addObject:storeAndAssistantModel];
//    }
//    //将整个门店和营业员数据分开，分别存到storeListArr和assistantListArr数组中,给营业员列表加全部字段
//    for (MMDStoreAndAssistantModel *model in storeAndAssistantModelArr) {
//        [storeListArr addObject:model.alliesName];
//        NSMutableArray *tempNameArray = [NSMutableArray array];
//        NSMutableArray *tempIdArray = [NSMutableArray array];
//        for (int j = 0; j < model.assistantList.count; j++) {
//            MMDAssistantListModel *listModel = model.assistantList[j];
//            [tempNameArray addObject:listModel.fullName];
//            [tempIdArray addObject:listModel.sellerNo];
//        }
//        //优惠券销售筛选,在添加全部字段的同时,门店下面添加自己作为验证方的筛选项
//        if (isCouponList) {
//            [tempNameArray insertObject:@"全部" atIndex:0];
//            [tempIdArray insertObject:model.alliesCode atIndex:0];
//            if (![model.alliesCode isEqual:[MMDUserModel shareInstance].merchantCodes]) {
//                [tempNameArray insertObject:model.alliesName atIndex:1];
//                [tempIdArray insertObject:model.alliesCode atIndex:1];
//            }
//        } else {
//            //非优惠券列表只需要添加全部字段
//            [tempNameArray insertObject:@"全部" atIndex:0];
//            [tempIdArray insertObject:@"" atIndex:0];
//        }
//        [allAssistantNameArr addObject:tempNameArray];
//        [allAssistantIDArr addObject:tempIdArray];
//    }
//    //当门店数量大于1时给门店列表添加全部字段
//    if (storeListArr.count > 1) {
//        [storeListArr insertObject:@"全部" atIndex:0];
//        [allAssistantNameArr insertObject:@[] atIndex:0];
//        [allAssistantIDArr insertObject:@[] atIndex:0];
//    }
//    NSDictionary *dataDict = @{@"storeListArr":storeListArr,
//                               @"allAssistantNameArr":allAssistantNameArr,
//                               @"allAssistantIDArr":allAssistantIDArr};
//    return dataDict;
//}

@end
