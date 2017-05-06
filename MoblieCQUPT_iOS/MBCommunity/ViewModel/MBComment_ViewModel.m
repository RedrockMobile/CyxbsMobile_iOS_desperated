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
    CGFloat nameY = imageY;
    CGSize nameSize = [_model.IDLabel sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _IDLabelFrame = (CGRect){{nameX,nameY},nameSize};
    
    //时间
    CGFloat timeX = nameX;
    CGSize timeSize = [_model.timeLabel sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    CGFloat timeY = CGRectGetMaxY(_headImageViewFrame) - timeSize.height;
    _timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
    
    //内容
    CGFloat contentX = CGRectGetMaxX(_headImageViewFrame) + MARGIN;
    CGFloat contentY = CGRectGetMaxY(_headImageViewFrame) + MARGIN;
    CGFloat contentW = ScreenWidth - contentX - MARGIN;
    CGRect contentSize = [_model.contentLabel boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _contentLabelFrame = (CGRect){{contentX,contentY},contentSize.size};
    
    self.cellHeight = CGRectGetMaxY(_contentLabelFrame) + MARGIN+5;
}

@end
