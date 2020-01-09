//
//  MMDMessageListTablesViewController.h
//  MeMeDaiSteward
//
//  Created by zhaozheng on 2016/10/23.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDMessageListViewModel.h"

@interface MMDMessageListTablesViewController : UIViewController

@property (nonatomic, strong) MMDMessageListViewModel *viewModel;
@property (nonatomic, strong) UITableView *messageListTableView;
@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, copy) NSString *msgType;
@property (nonatomic, copy) NSString *remindText;

- (instancetype)initWithViewModel:(MMDMessageListViewModel *)viewModel;
- (void)setAutoRefreshRequest;

@end
