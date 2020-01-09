//
//  MMDTableViewCell.h
//  MeMeDaiSteward
//
//  Created by qian on 16/9/2.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMDTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;

+ (id)cellForTableView:(UITableView *)tableView;

//计算Cell内布局的高度
+ (CGFloat)cellHeight:(id)viewModel index:(NSUInteger)index;

//设置内容
- (void)setupContentView;

//绑定ViewModel
- (void)bindViewModel:(id)viewModel atIndexPath:(NSIndexPath *)indexPath;

@end
