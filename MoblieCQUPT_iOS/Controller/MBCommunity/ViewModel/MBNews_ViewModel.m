//
//  MBNews_ViewModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/8/18.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBNews_ViewModel.h"
#define MARGIN 10

@implementation MBNews_ViewModel
- (void)setModel:(MBNewsModel *)model {
    _model = model;
    
    [self setupFrame];
}

- (void)setupFrame {
    //头像
    CGFloat imageX = MARGIN;
    CGFloat imageY = 20;
    CGFloat imageWH = 35;
    _headImageViewFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_headImageViewFrame) + MARGIN;
    CGFloat nameY = imageY;
    CGSize nameSize = [_model.IDLabel sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _IDLabelFrame = (CGRect){{nameX,nameY},nameSize};
    
    //时间
    CGFloat timeX = nameX;
    CGSize timeSize = [_model.date sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat timeY = CGRectGetMaxY(_headImageViewFrame) - timeSize.height;
    _timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
    
    //内容
    CGFloat contentX = imageX;
    CGFloat contentY = CGRectGetMaxY(_headImageViewFrame) + MARGIN+5;
    CGFloat contentW = ScreenWidth - 2 * contentX;
    CGRect contentSize = [_model.title boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    _contentLabelFrame = (CGRect){{contentX,contentY},contentSize.size};
    
    
    _photoContainerViewFrame = (CGRect){{0,0},{0,0}};
    
    //评论
    CGSize commentSize = [_model.numOfRemark sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat commentX = ScreenWidth - commentSize.width - 15;
    CGFloat commentY = CGRectGetMaxY(self.contentLabelFrame) + 13;
    _numOfCommentFrame = (CGRect){{commentX,commentY},commentSize};
    
    CGFloat commentImageX = CGRectGetMinX(_numOfCommentFrame) - 19;
    CGFloat commentImageY = CGRectGetMaxY(self.contentLabelFrame) + 15;
    CGFloat commentImageW = 29/2;
    CGFloat commentImageH = 26/2;
    _commentImageFrame = (CGRect){{commentImageX,commentImageY},{commentImageW,commentImageH}};
    
    //点赞
    CGSize supportSize = [_model.numOfLike sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat supportX = CGRectGetMinX(_commentImageFrame) - 30 - supportSize.width;
    CGFloat supportY = CGRectGetMaxY(self.contentLabelFrame) + 14;
    _numOfSupportFrame = (CGRect){{supportX,supportY},supportSize};
    
    CGFloat supportImageX = CGRectGetMinX(_numOfSupportFrame) - 19;
    CGFloat supportImageY = CGRectGetMaxY(self.contentLabelFrame) + 15;
    CGFloat supportImageW = 28/2;
    CGFloat supportImageH = 27/2;
    _supportImageFrame = (CGRect){{supportImageX,supportImageY},{supportImageW,supportImageH}};
    
    self.cellHeight = CGRectGetMaxY(_numOfSupportFrame) + MARGIN+5;
}
@end
