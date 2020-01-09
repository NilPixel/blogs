//
//  MMDMessageListViewModel.m
//  MeMeDaiSteward
//
//  Created by Mime97 on 2016/10/20.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDMessageListViewModel.h"
#import "MMDTestService.h"
#import "MJRefresh.h"
#import "MMDLoginModel.h"

#define THREE_MINUTES 600000

@implementation MMDMessageListViewModel

- (NSMutableArray<MMDMessageListModel *> *)messageListArray {
    if (!_messageListArray) {
        _messageListArray = [NSMutableArray array];
    }
    return _messageListArray;
}

- (void)login {
    NSDictionary *params = @{@"username":@"yanbei",@"password":[MMDMD5Utils encrypt:@"123456"],@"encrypt":@YES};
    [MMDTestService userLoginWithParams:params callBack:^(MMDResponse *response) {
        if (response.isSuccess) {
            MMDLoginModel *loginModel = response.result;
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.userToken.token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}

#pragma mark - 消息列表请求
- (void)getMessageListCallBack:(void (^)(MMDResponse *))callBack DataLoadingType:(DataLoadingType)loadingType {
    NSDictionary *paramsDict;
    if (loadingType == DataLoadingTypeRefresh) {
        paramsDict = @{@"currentPage":@(1),
                       @"msgType":self.msgType};
    } else if (loadingType == DataLoadingTypeInfinite) {
        paramsDict = @{@"currentPage":@(self.currentPage + 1),
                       @"msgType":self.msgType};
    }
    [MMDTestService getMessageListWithParams:paramsDict responseCache:^(id responseCache) {
        if (loadingType == DataLoadingTypeRefresh) {
            self.currentPage = 1;
            self.messageListArray = [responseCache mutableCopy];
        }
    } callBack:^(MMDResponse *response) {
        if (response.isSuccess) {
            if ([response.result count] > 0) {
                if (loadingType == DataLoadingTypeRefresh) {
                    self.currentPage = 1;
                    self.messageListArray = [response.result mutableCopy];
//                    [self saveCacheData];
                } else if (loadingType == DataLoadingTypeInfinite) {
                    self.currentPage += 1;
                    [self.messageListArray addObjectsFromArray:response.result];
                }
            }
            [self saveTheLastRefreshTime];
            }
        if (callBack) {
            callBack(response);
        }
    }];
}

#pragma mark - 碎片交互响应
- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.messageListArray count];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight + 62;
}

- (MMDMessageListModel *)messageAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.messageListArray.count) {
        return nil;
    }
    return self.messageListArray[index];
}

- (void)saveTheLastRefreshTime {
    NSNumber *nowTime = [NSNumber numberWithLongLong:[[MMDDateUtils getTimestamp] longLongValue]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nowTime forKey:self.msgType];
    [defaults synchronize];
}

//- (void)saveCacheData {
//    self.cacheDataArray = [self.messageListArray copy];
//    [MMDMessageService saveCacheData:self.cacheDataArray forKey:[NSString stringWithFormat:@"%@_%@",[MMDUserModel shareInstance].userName,self.msgType]];
//}
//
//- (NSArray *)getCacheData {
//    return [MMDMessageService getCachaDataWithKey:[NSString stringWithFormat:@"%@_%@",[MMDUserModel shareInstance].userName,self.msgType]];
//}

@end
