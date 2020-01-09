//
//  MMDMessageListViewModel.h
//  MeMeDaiSteward
//
//  Created by Mime97 on 2016/10/20.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDBaseViewModel.h"
#import "MMDMessageResultModel.h"

@interface MMDMessageListViewModel : MMDBaseViewModel

@property (nonatomic, strong) NSMutableArray <MMDMessageListModel *> *messageListArray;     //装消息列表数据数组
@property (nonatomic, assign) NSInteger currentPage;                                            //当前页码
@property (nonatomic, copy) NSString *msgType;                                                  //消息类型(请求参数)
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSArray *cacheDataArray;                                          //存储首页缓存数组
@property (nonatomic, assign) BOOL isAccountChanged;                                            //是否更换账号
@property (nonatomic, assign) BOOL isJumpedToDetail;                                            //是否进入过消息详情
@property (nonatomic, assign) BOOL isTableNeedRefresh;                                          //列表是否需要刷新

//请求网络获取列表数据
- (void)getMessageListCallBack:(void (^)(MMDResponse *))callBack DataLoadingType:(DataLoadingType)loadingType;
//ViewModel 输出
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//Model 输出
- (MMDMessageListModel *)messageAtIndex:(NSInteger)index;
//- (NSArray *)getCacheData;

@end
