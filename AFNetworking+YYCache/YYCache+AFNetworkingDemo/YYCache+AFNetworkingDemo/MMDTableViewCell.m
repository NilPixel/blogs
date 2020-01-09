//
//  MMDTableViewCell.m
//  MeMeDaiSteward
//
//  Created by qian on 16/9/2.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDTableViewCell.h"

@implementation MMDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView {
    
}

- (id)initWithCellIdentifier:(NSString *)cellID {
    return [self initWithStyle:UITableViewCellStyleDefault
               reuseIdentifier:cellID];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellID];
    }
    return cell;
}

+ (CGFloat)cellHeight:(id)viewModel index:(NSUInteger)index {
    return 0;
}

- (void)bindViewModel:(id)viewModel atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
