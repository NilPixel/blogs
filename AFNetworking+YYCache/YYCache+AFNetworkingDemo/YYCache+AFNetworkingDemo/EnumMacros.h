//
//  EnumMacros.h
//  MeMeDaiSteward
//
//  Created by  on 16/8/11.
//  Copyright © 2016年 Mime. All rights reserved.
//

#ifndef EnumMacros_h
#define EnumMacros_h

//下拉菜单层级
typedef NS_ENUM(NSUInteger, MenuSelectTpye) {
    MenuSelectTpye_hasLevelNone = 0,            //无下拉菜单
    MenuSelectTpye_hasLevelOne = 1,             //包含一级下拉菜单
    MenuSelectTpye_hasLevelTow = 2,             //包含二级下拉菜单
};

//角色分类
typedef NS_ENUM(NSUInteger, UserRoleType) {
    UserRoleType_Merchant           = 0,        //商户角色
    UserRoleType_Area               = 1,        //大区角色
    UserRoleType_Store              = 2,        //门店角色
    UserRoleType_Assistant          = 3,        //营业员角色
};

//订单快捷入口分类
typedef NS_ENUM(NSUInteger, OrderClassifyType) {
    OrderClassifyType_Apply           = 0,      //申请件
    OrderClassifyType_ToConfirm       = 1,      //待确认件
    OrderClassifyType_ToLoan          = 2,      //待放款件
    OrderClassifyType_Loan            = 3,      //放款件
};

typedef NS_ENUM(NSInteger, DataLoadingType) {
    DataLoadingTypeRefresh = 1,  //刷新数据
    DataLoadingTypeInfinite = 2, //下一页数据
};

/** 缓存的Block */
typedef void(^MMDResponseCache)(id responseCache);

#endif /* EnumMacros_h */
