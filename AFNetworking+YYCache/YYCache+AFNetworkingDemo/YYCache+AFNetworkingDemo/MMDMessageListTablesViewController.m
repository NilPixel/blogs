//
//  MMDMessageListTablesViewController.m
//  MeMeDaiSteward
//
//  Created by zhaozheng on 2016/10/23.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDMessageListTablesViewController.h"
#import "MMDMessageListCell.h"
#import "MJRefresh.h"

#define THREE_MINUTES 10000

@interface MMDMessageListTablesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation MMDMessageListTablesViewController

- (instancetype)initWithViewModel:(MMDMessageListViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MMDMessageListViewModel alloc]init];
    self.viewModel.msgType = @"";
    self.viewModel.currentPage = 1;
    [self setUpTableView];
//    [self loadCacheDatas];
    [self setRequestReturnValueWithDataLoadingType:DataLoadingTypeRefresh];}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//重置跳转到消息详情的tableview的标志位
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.viewModel.isJumpedToDetail = NO;
}

- (UITableView *)messageListTableView {
    if (!_messageListTableView) {
        _messageListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _messageListTableView.delegate = self;
        _messageListTableView.dataSource = self;
        _messageListTableView.showsVerticalScrollIndicator = NO;
        _messageListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _messageListTableView.backgroundColor = [UIColor lightGrayColor];
    }
    return _messageListTableView;
}

- (void)setUpTableView {
    [self.view addSubview:self.messageListTableView];
    [self.messageListTableView addSubview:self.remindLabel];
    self.remindLabel.hidden = YES;
    MJWeakSelf
    self.messageListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setRequestReturnValueWithDataLoadingType:DataLoadingTypeRefresh];
    }];
    self.messageListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf setRequestReturnValueWithDataLoadingType:DataLoadingTypeInfinite];
    }];
}

- (UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.messageListTableView.frame.size.height*0.5-10, kSCREEN_WIDTH, 20)];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _remindLabel.text = self.remindText;
    }
    return _remindLabel;
}

- (void)setAutoRefreshRequest {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long long int nowTime = [[MMDDateUtils getTimestamp] longLongValue];
    long long int lastRefreshTime = [[defaults objectForKey:self.msgType] longLongValue];
//            if (((nowTime - lastRefreshTime >= THREE_MINUTES) || self.viewModel.isTableNeedRefresh) && !self.viewModel.isJumpedToDetail) {
//                self.viewModel.isTableNeedRefresh = NO;
                [self.messageListTableView.mj_header beginRefreshing];
//            }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setRequestReturnValueWithDataLoadingType:(DataLoadingType)loadingType {
    MJWeakSelf
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.viewModel getMessageListCallBack:^(MMDResponse *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response.isSuccess) {
            if ([response.result count] == 0) {
                if (weakSelf.viewModel.currentPage == 1) {
                    weakSelf.remindLabel.hidden = NO;
                    weakSelf.messageListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                } else {
//                    [weakSelf showToastForViewWithMessage:@"没有更多数据"];
                }
            } else {
                weakSelf.remindLabel.hidden = YES;
                [weakSelf.messageListTableView reloadData];
                weakSelf.messageListTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            }
            [weakSelf resetIsChangedFlag];
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];//刷新成功清空通知栏的消息
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        } else if (response.responseCode != TOKENOUTDATECODE) {
//            [weakSelf showToastForViewWithMessage:response.responseContent];
        }
        [weakSelf.messageListTableView.mj_header endRefreshing];
        if (weakSelf.viewModel.messageListArray.count == 0) {
            weakSelf.messageListTableView.mj_footer.hidden = YES;
        } else {
            [weakSelf.messageListTableView.mj_footer endRefreshing];
            weakSelf.messageListTableView.mj_footer.hidden = NO;
        }
    } DataLoadingType:loadingType];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMDMessageListCell *cell = [MMDMessageListCell cellForTableView:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    [cell bindViewModel:self.viewModel atIndexPath:indexPath];
    self.viewModel.cellHeight = cell.cellHeight;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MMDMessageListCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.titleLb.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
//    NSString *msgId = [self.viewModel.messageListArray[indexPath.row] msgId];
//    self.viewModel.messageListArray[indexPath.row].msgStatus = @"1";
//    self.viewModel.isJumpedToDetail = YES;
//    [self setOtherTableMessageReadedStatusWithMsgId:msgId];
////    MMDMessageDetailViewController *messageDetailVC = [[MMDMessageDetailViewController alloc] init];
////    messageDetailVC.msgId = msgId;
//    NSDictionary *dic = @{@"查看消息详情":self.yp_tabItemTitle};
//    [TalkingData trackEvent:@"消息" label:@"查看消息详情" parameters:dic];
//    [self.parentViewController.navigationController pushViewController:messageDetailVC animated:YES];
}

- (void)viewDidLayoutSubviews {
    if ([self.messageListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.messageListTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.messageListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.messageListTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)resetIsChangedFlag {
    self.viewModel.isAccountChanged = NO;
}

//- (void)setOtherTableMessageReadedStatusWithMsgId:(NSString *)msgId {
//    NSArray *controllerArray = [MMDTabBarController defaultInstance].messageViewController.viewControllers;
//    for (MMDMessageListTablesViewController *controller in controllerArray) {
//        if (controller.viewModel.messageListArray) {
//            for (MMDMessageListModel *model in controller.viewModel.messageListArray) {
//                if ([msgId isEqualToString:model.msgId]) {
//                    model.msgStatus = @"1";//将消息标记成已读  @“0”是未读、@“1”是已读
//                }
//            }
//            [controller.messageListTableView reloadData];
//        }
//    }
//}

- (void)loadCacheDatas {
//    NSLog(@"##############getCacheData###############%@",[self.viewModel getCacheData]);
//    self.viewModel.messageListArray = [[self.viewModel getCacheData] mutableCopy];
    if (!self.viewModel.messageListArray.count) {
        if (!self.viewModel.isAccountChanged) {
            self.remindLabel.hidden = NO;
            self.messageListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    } else {
        self.messageListTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    [self.messageListTableView reloadData];
}

@end
