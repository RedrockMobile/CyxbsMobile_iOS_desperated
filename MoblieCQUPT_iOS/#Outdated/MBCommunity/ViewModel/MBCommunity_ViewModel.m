//
//  MBCommunity_ViewModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunity_ViewModel.h"

#define MARGIN 10
@implementation MBCommunity_ViewModel

- (void)setModel:(MBCommunityModel *)model {
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
    CGSize nameSize = [_model.nickname sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _IDLabelFrame = (CGRect){{nameX,nameY},nameSize};
    
    //时间
    CGFloat timeX = nameX;
    CGSize timeSize = [_model.time sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat timeY = CGRectGetMaxY(_headImageViewFrame) - timeSize.height;
    _timeLabelFrame = (CGRect){{timeX,timeY},timeSize};


    //内容
    CGFloat contentX = imageX;
    CGFloat contentY = CGRectGetMaxY(_headImageViewFrame) + MARGIN+5;
    CGFloat contentW = SCREEN_WIDTH - 2 * contentX;
    CGRect contentSize = [_model.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGRect detailContentSize = [_model.detailContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _contentLabelFrame = (CGRect){{contentX,contentY},contentSize.size};
    _detailContentLabelFrame = (CGRect){{contentX,contentY},detailContentSize.size};

    //收缩内容
    CGFloat coverContentX = imageX;
    CGFloat coverContentY;
    /*
     if (picCount == 0) {
     coverContentY = CGRectGetMaxY(_photoContainerViewFrame);
     } else {
     coverContentY = CGRectGetMaxY(_photoContainerViewFrame) + MARGIN+5;
     }
     */
    coverContentY = CGRectGetMaxY(_headImageViewFrame) + MARGIN + 5;
    CGFloat coverContentW = SCREEN_WIDTH - 2 * contentX;
    CGFloat coverContentH = [UIFont systemFontOfSize:15].lineHeight * 2;
    CGRect coverContentRect = CGRectMake(coverContentX, coverContentY, coverContentW, coverContentH);
    _coverContentLabelFrame = coverContentRect;
    
    CGFloat height = [self.model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-18, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGFloat twoLinesHeight = [UIFont systemFontOfSize:14].lineHeight * 2;
    
    //展开按钮
    if (height > twoLinesHeight) {
        self.extendLabelFrame = CGRectMake(_headImageViewFrame.origin.x, CGRectGetMaxY(_coverContentLabelFrame) + 12, 45, 25);
    } else {
        self.extendLabelFrame = _contentLabelFrame;
    }
    
    
    
    //图片容器
    CGFloat photoContainerX = MARGIN;
    CGFloat photoContainerY = CGRectGetMaxY(_extendLabelFrame) + MARGIN+5;
    CGFloat detailPhotoContainerY = CGRectGetMaxY(_detailContentLabelFrame) + MARGIN+5;

    CGFloat photoContainerW;
    CGFloat photoContainerH;
    NSInteger picCount = self.model.articlePictureArray.count;
    if (picCount == 4) {
        photoContainerW = kPhotoImageViewW * 2 + 2;
        photoContainerH = photoContainerW;
    }else if (picCount == 1){
        photoContainerW = kPhotoImageViewW*1.5;
        photoContainerH = kPhotoImageViewW*1.5;
    }else if (picCount == 0){
        photoContainerW = 0;
        photoContainerH = 0;
    }else {// picCount = 2 3 5 6 7 8 9张
        //算出每行有几个图片
        NSInteger perRowItemCount;
        NSInteger perColunmItemCount;
        if (picCount <= 3) {
            perRowItemCount = picCount;
            perColunmItemCount = 1;
        }else {
            perRowItemCount = 3;
            if (picCount < 7) {
                perColunmItemCount = 2;
            }else {
                perColunmItemCount = 3;
            }
        }
        photoContainerW = kPhotoImageViewW * perRowItemCount + (perRowItemCount - 2) * 1;
        photoContainerH = kPhotoImageViewW * perColunmItemCount + (perColunmItemCount - 2) * 1;
    }
    _photoContainerViewFrame = (CGRect){{photoContainerX,photoContainerY},{photoContainerW,photoContainerH}};
    _detailPhotoContainerViewFrame = (CGRect){{photoContainerX,detailPhotoContainerY},{photoContainerW,photoContainerH}};
    
    
    
/*
    //内容
    CGFloat contentX = imageX;
    CGFloat contentY;
    if (picCount == 0) {
        contentY = CGRectGetMaxY(_photoContainerViewFrame);
    } else {
        contentY = CGRectGetMaxY(_photoContainerViewFrame) + MARGIN+5;
    }
    CGFloat contentW = SCREEN_WIDTH - 2 * contentX;
    CGRect contentSize = [_model.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGRect detailContentSize = [_model.detailContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _contentLabelFrame = (CGRect){{contentX,contentY},contentSize.size};
    _detailContentLabelFrame = (CGRect){{contentX,contentY},detailContentSize.size};
*/
    
    

    
    
//    CGFloat height = [self.model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-18, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//    
//    CGFloat twoLinesHeight = [UIFont systemFontOfSize:14].lineHeight * 2;
    
    CGRect contentLastFrame;
    CGRect detailLastFrame;
    
    if (picCount == 0) {
        if (height > twoLinesHeight) {
            contentLastFrame = self.extendLabelFrame;
        } else {
            contentLastFrame = self.contentLabelFrame;
        }
        detailLastFrame = self.detailContentLabelFrame;
    } else {
        contentLastFrame = _photoContainerViewFrame;
        detailLastFrame = self.detailPhotoContainerViewFrame;
    }
    
    /*
    if (_photoContainerViewFrame.size.height == 0) {
        if (height > twoLinesHeight) {
            contentLastFrame = self.coverContentLabelFrame;
        } else {
            self.coverContentLabelFrame = self.contentLabelFrame;
            contentLastFrame = self.contentLabelFrame;
        }
        detailLastFrame = self.detailContentLabelFrame;

    }else {
        if (height > twoLinesHeight) {
            contentLastFrame = self.coverContentLabelFrame;
        } else {
            self.coverContentLabelFrame = self.contentLabelFrame;
            contentLastFrame = self.contentLabelFrame;
        }
        detailLastFrame = self.detailContentLabelFrame;
    }
     */

//展开按钮 虚线
//    if (height > twoLinesHeight) {
//        self.extendLabelFrame = CGRectMake(_headImageViewFrame.origin.x, CGRectGetMaxY(_contentLabelFrame) + 12, 32, 18);
//    } else {
//        self.extendLabelFrame = contentLastFrame;
//    }
    
    self.dottedLineImageViewFrame = CGRectMake(_headImageViewFrame.origin.x, CGRectGetMaxY(contentLastFrame) + 12, SCREEN_WIDTH - _headImageViewFrame.origin.x * 2, 1);
    
//点赞 评论数
    
    CGSize numOfCommentSize = [_model.remark_num.stringValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    CGFloat numOfCommentX = SCREEN_WIDTH - numOfCommentSize.width - 10;
    CGFloat numOfCommentY = CGRectGetMaxY(self.dottedLineImageViewFrame) + 16;
    self.numOfCommentFrame = (CGRect){{numOfCommentX, numOfCommentY}, numOfCommentSize};
    
    CGFloat commentImageX = CGRectGetMinX(self.numOfCommentFrame) - 26;
    CGFloat commentImageY = CGRectGetMaxY(self.dottedLineImageViewFrame) + 16;
    self.commentImageviewFrame = CGRectMake(commentImageX, commentImageY, 18, 18);
    
    CGSize numOfUpvoteSize = [_model.like_num.stringValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    CGFloat numOfUpvoteX = CGRectGetMinX(self.commentImageviewFrame) - 12 - numOfUpvoteSize.width;
    CGFloat numOfUpvoteY = CGRectGetMaxY(self.dottedLineImageViewFrame) + 16;
    self.numOfUpvoteFrame = (CGRect){{numOfUpvoteX, numOfUpvoteY}, numOfUpvoteSize};
    
    CGFloat upvoteImageX = CGRectGetMinX(self.numOfUpvoteFrame) - 26;
    CGFloat upvoteImageY = CGRectGetMaxY(self.dottedLineImageViewFrame) + 16;
    self.upvotebtnFrame = CGRectMake(upvoteImageX, upvoteImageY, 18,  18);

//点击展开后的一套frame
    self.extend_contentLabelFrame = CGRectMake(_coverContentLabelFrame.origin.x, _coverContentLabelFrame.origin.y, self.contentLabelFrame.size.width, self.contentLabelFrame.size.height);
    self.extend_extendLabelFrame = CGRectMake(_headImageViewFrame.origin.x, CGRectGetMaxY(_extend_contentLabelFrame) + 12, 45, 25);
    
    if (picCount != 0) {
        self.extend_photoContainerViewFrame = CGRectMake(self.photoContainerViewFrame.origin.x, CGRectGetMaxY(self.extend_extendLabelFrame) + MARGIN + 5, self.photoContainerViewFrame.size.width, self.photoContainerViewFrame.size.height);
    } else {
        self.extend_photoContainerViewFrame = self.extend_extendLabelFrame;
    }
    
    self.extend_dottedLineImageViewFrame = CGRectMake(_headImageViewFrame.origin.x, CGRectGetMaxY(self.extend_photoContainerViewFrame) + 12, SCREEN_WIDTH - _headImageViewFrame.origin.x * 2, 1);
    
    
    CGSize extend_numOfCommentSize = [_model.remark_num.stringValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    CGFloat extend_numOfCommentX = SCREEN_WIDTH - extend_numOfCommentSize.width - 10;
    CGFloat extend_numOfCommentY = CGRectGetMaxY(self.extend_dottedLineImageViewFrame) + 16;
    self.extend_numOfCommentFrame = (CGRect){{extend_numOfCommentX, extend_numOfCommentY}, extend_numOfCommentSize};
    
    CGFloat extend_commentImageX = CGRectGetMinX(self.extend_numOfCommentFrame) - 26;
    CGFloat extend_commentImageY = CGRectGetMaxY(self.extend_dottedLineImageViewFrame) + 16;
    self.extend_commentImageviewFrame = CGRectMake(extend_commentImageX, extend_commentImageY, 18, 18);
    
    CGSize extend_numOfUpvoteSize = [_model.like_num.stringValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    CGFloat extend_numOfUpvoteX = CGRectGetMinX(self.extend_commentImageviewFrame) - 12 - extend_numOfUpvoteSize.width;
    CGFloat extend_numOfUpvoteY = CGRectGetMaxY(self.extend_dottedLineImageViewFrame) + 16;
    self.extend_numOfUpvoteFrame = (CGRect){{extend_numOfUpvoteX, extend_numOfUpvoteY}, extend_numOfUpvoteSize};
    
    CGFloat extend_upvoteImageX = CGRectGetMinX(self.extend_numOfUpvoteFrame) - 26;
    CGFloat extend_upvoteImageY = CGRectGetMaxY(self.extend_dottedLineImageViewFrame) + 16;
    self.extend_upvotebtnFrame = CGRectMake(extend_upvoteImageX, extend_upvoteImageY, 18,  18);
    
    
    //评论
/*    CGSize commentSize = [_model.remark_num.stringValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat commentX = SCREEN_WIDTH - commentSize.width - 15;
    CGFloat commentY = CGRectGetMaxY(lastFrame) + 13;
    CGFloat detailCommentY = CGRectGetMaxY(detailLastFrame) +13;
    _numOfCommentFrame = (CGRect){{commentX,commentY},commentSize};
    _detailNumOfCommentFrame = (CGRect){{commentX,detailCommentY},commentSize};
*/
    
/*    CGFloat commentImageX = CGRectGetMinX(_numOfCommentFrame ) - 19;
    CGFloat commentImageY = CGRectGetMaxY(lastFrame) + 15;
    CGFloat detailCommentImageY = CGRectGetMaxY(detailLastFrame) + 15;
    CGFloat commentImageW = 29/2;
    CGFloat commentImageH = 26/2;
    _commentImageFrame = (CGRect){{commentImageX,commentImageY},{commentImageW,commentImageH}};
    _detailCommentImageFrame = (CGRect){{commentImageX,detailCommentImageY},{commentImageW,commentImageH}};
*/
    
    //点赞
/*    CGSize supportSize = [_model.like_num.stringValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat supportX = CGRectGetMinX(_commentImageFrame) - 30 - supportSize.width;
    CGFloat supportY = CGRectGetMaxY(lastFrame) + 14;
    CGFloat detailSupportX = CGRectGetMinX(_detailCommentImageFrame) - 30 - supportSize.width;

    CGFloat detailSupportY = CGRectGetMaxY(detailLastFrame) + 14;
*/
    
/*    _numOfSupportFrame = (CGRect){{supportX,supportY},supportSize};
    _detailNumOfSupportFrame =  (CGRect){{detailSupportX,detailSupportY},supportSize};

    
    CGFloat supportImageX = CGRectGetMinX(_numOfSupportFrame) - 19;
    CGFloat supportImageY = CGRectGetMaxY(lastFrame) + 15;
    CGFloat detailSupportImageX = CGRectGetMinX(_detailNumOfSupportFrame) - 19;
    CGFloat detailSupportImageY = CGRectGetMaxY(detailLastFrame)+15;
    CGFloat supportImageW = 28/2;
    CGFloat supportImageH = 27/2;
    _supportImageFrame = (CGRect){{supportImageX,supportImageY},{supportImageW,supportImageH}};
    _detailSupportImageFrame = (CGRect){{detailSupportImageX,detailSupportImageY},{supportImageW,supportImageH}};
 */
        
//    self.cellHeight = CGRectGetMaxY(_numOfSupportFrame) + MARGIN+5;
    self.cellHeight = CGRectGetMaxY(self.upvotebtnFrame) + 14;
    self.detailCellHeight = CGRectGetMaxY(detailLastFrame) + MARGIN+5;
    self.extend_cellHeight = CGRectGetMaxY(self.extend_upvotebtnFrame) + 14;
    
    
    
}

@end
