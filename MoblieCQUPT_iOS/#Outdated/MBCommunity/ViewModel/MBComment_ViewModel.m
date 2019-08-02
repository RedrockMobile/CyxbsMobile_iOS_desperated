//
//  MBComment_ViewModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBComment_ViewModel.h"
#define MARGIN 10

@implementation MBComment_ViewModel

- (void)setModel:(MBCommentModel *)model {
    _model = model;
    
    [self setupFrame];
}

- (void)setupFrame {
    //头像
    CGFloat imageX = MARGIN;
    CGFloat imageY = 15;
    CGFloat imageWH = 30;
    _headImageViewFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_headImageViewFrame) + MARGIN;
    CGSize nameSize = [_model.nickname sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat nameY = imageY + (30 - nameSize.height)/2.0;
    _IDLabelFrame = (CGRect){{nameX,nameY},nameSize};
    
    //时间
    CGSize timeSize = [_model.created_time sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat timeX = SCREEN_WIDTH - timeSize.width - 17;
    CGFloat timeY = CGRectGetMinY(_IDLabelFrame) + (_IDLabelFrame.size.height - timeSize.height) / 2.0;
    _timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
    
    //内容
    CGFloat contentX = CGRectGetMaxX(_headImageViewFrame) + MARGIN;
    CGFloat contentY = CGRectGetMaxY(_headImageViewFrame) + MARGIN;
    CGFloat contentW = SCREEN_WIDTH - contentX - MARGIN;
    CGRect contentSize = [_model.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _contentLabelFrame = (CGRect){{contentX,contentY},contentSize.size};
    
    self.cellHeight = CGRectGetMaxY(_contentLabelFrame) + MARGIN+5;
}

@end
