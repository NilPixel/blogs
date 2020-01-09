//
//  MMDMessageListCell.h
//  MeMeDaiSteward
//
//  Created by Mime97 on 2016/10/20.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDTableViewCell.h"

@interface MMDMessageListCell : MMDTableViewCell

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, assign) CGFloat cellHeight;

@end
