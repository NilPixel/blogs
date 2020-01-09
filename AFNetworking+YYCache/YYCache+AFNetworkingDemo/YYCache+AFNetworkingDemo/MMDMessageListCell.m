//
//  MMDMessageListCell.m
//  MeMeDaiSteward
//
//  Created by Mime97 on 2016/10/20.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDMessageListCell.h"
#import "MMDMessageListViewModel.h"

#define LABEL_WIDTH (kSCREEN_WIDTH - 30)
#define OFFSET_X 15
#define OFFSET_Y 15
#define TITLE_FONT_SIZE 15
#define CONTENT_FONT_SIZE 12
#define TIME_FONT_SIZE 12

@implementation MMDMessageListCell

- (void)setupContentView {
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.contentLb];
    [self.contentView addSubview:self.timeLb];
}

- (void)bindViewModel:(MMDMessageListViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath {
    MMDMessageListModel *messageListRowsModel = [viewModel messageAtIndex:indexPath.row];
    self.titleLb.text = messageListRowsModel.msgTitle;
    //判断消息是否已读
    if ([@"0" isEqual:messageListRowsModel.msgStatus]) {
        self.titleLb.textColor = [UIColor colorWithHexString:@"#333333"];
    } else if ([@"1" isEqual:messageListRowsModel.msgStatus]) {
        self.titleLb.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
    }
    //指定字符串截取,通过算法给contentlabel赋特定格式的值，达到要求只显示两行到头，多余的省略的效果
    NSString *string = nil;
    if ([messageListRowsModel.msgContent rangeOfString:@"\n"].location !=NSNotFound) {
        NSArray *contentArray = [messageListRowsModel.msgContent componentsSeparatedByString:@"\n"];
        string = [contentArray objectAtIndex:0];
        string = [string stringByAppendingFormat:@"%@",@"\n"];
        for (int i = 1; i < contentArray.count ; i ++) {
            NSString *str = contentArray[i];
            string = [string stringByAppendingFormat:@"%@  ",str];
        }
    } else {
        string = messageListRowsModel.msgContent;
    }
    self.contentLb.text = string;
    //time赋值
    self.timeLb.text = messageListRowsModel.sentTime == 0 ?@"--":[MMDDateUtils getAccurateTimeFromTimeInterval:messageListRowsModel.sentTime /1000];
    //三个label的frame的设置
    CGFloat titleHeight = [self getHeightWithFontSize:TITLE_FONT_SIZE withWidth:LABEL_WIDTH withText:self.titleLb.text withLableIndex:0];
    [self.titleLb setFrame:CGRectMake(OFFSET_X, 31, LABEL_WIDTH, titleHeight)];
    CGFloat contentHeight = [self getHeightWithFontSize:CONTENT_FONT_SIZE withWidth:LABEL_WIDTH withText:self.contentLb.text withLableIndex:1];
    [self.contentLb setFrame: CGRectMake(OFFSET_X, self.titleLb.frame.origin.y + self.titleLb.frame.size.height + 13, LABEL_WIDTH, contentHeight + 8)];
    CGFloat timeHeight = [self getHeightWithFontSize:TIME_FONT_SIZE withWidth:LABEL_WIDTH withText:self.timeLb.text withLableIndex:0];
    [self.timeLb setFrame:CGRectMake(OFFSET_X, self.titleLb.frame.origin.y + self.titleLb.frame.size.height + 13 + self.contentLb.frame.size.height + 18, LABEL_WIDTH, timeHeight)];
    //总的Frame
    CGFloat height = self.titleLb.frame.origin.y + self.titleLb.frame.size.height  + self.contentLb.frame.size.height  + self.timeLb.frame.size.height;
    self.cellHeight = height;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.numberOfLines = 1;
        _titleLb.font = FONT_PF_SEMIBOLD(15);
        _titleLb.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLb;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.numberOfLines = 2;
        _contentLb.textColor = [UIColor colorWithHexString:@"#666666"];
        self.contentLb.font = FONT_PF_LIGHT(12);
    }
    return _contentLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLb.font = FONT_PF_LIGHT(12);
    }
    return _timeLb;
}

//计算文本的高度
- (CGFloat)getHeightWithFontSize:(CGFloat)fontSize withWidth:(CGFloat)width withText:(NSString *)text withLableIndex:(NSInteger)index {
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH - 30, 0)];
    cellLabel.font = [UIFont systemFontOfSize:fontSize];
    if (index == 1) {
        cellLabel.numberOfLines = 2;
        //指定字符串截取
        NSString *string = nil;
        if ([text rangeOfString:@"\n"].location != NSNotFound) {
            NSArray *contentArray = [self.contentLb.text componentsSeparatedByString:@"\n"];
            string = [contentArray objectAtIndex:0];
            string = [string stringByAppendingFormat:@"%@",@"\n"];
            for (int i = 1; i < contentArray.count; i ++) {
                NSString *str = contentArray[i];
                string = [string stringByAppendingFormat:@"%@",str];
            }
        } else {
            string = text;
        }
        text = string;
    } else {
        cellLabel.numberOfLines = 1;
    }
    cellLabel.text = text;
    CGSize size = [cellLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return size.height;
}

@end
