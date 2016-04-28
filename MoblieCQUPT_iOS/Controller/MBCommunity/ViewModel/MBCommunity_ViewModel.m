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
    CGSize nameSize = [_model.IDLabel sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _IDLabelFrame = (CGRect){{nameX,nameY},nameSize};
    
    //时间
    CGFloat timeX = nameX;
    CGSize timeSize = [_model.timeLabel sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat timeY = CGRectGetMaxY(_headImageViewFrame) - timeSize.height;
    _timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
    
    //内容
    CGFloat contentX = imageX;
    CGFloat contentY = CGRectGetMaxY(_headImageViewFrame) + MARGIN+5;
    CGFloat contentW = ScreenWidth - 2 * contentX;
    CGRect contentSize = [_model.contentLabel boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    _contentLabelFrame = (CGRect){{contentX,contentY},contentSize.size};
    
    //图片容器
    CGFloat photoContainerX = MARGIN;
    CGFloat photoContainerY = CGRectGetMaxY(_contentLabelFrame) + MARGIN+5;
    CGFloat photoContainerW;
    CGFloat photoContainerH;
    NSInteger picCount = self.model.pictureArray.count;
    if (picCount == 4) {
        photoContainerW = kPhotoImageViewW * 2 + 2;
        photoContainerH = photoContainerW;
    }else if (picCount == 1){
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:self.model.pictureArray[0]];
        if (imageView.image.size.width == imageView.image.size.height) {
            imageView.frame = CGRectMake(0, 0, kPhotoImageViewW*1.2, kPhotoImageViewW*1.2);
            photoContainerW = imageView.frame.size.width;
            photoContainerH = imageView.frame.size.height;
        }else if (imageView.image.size.width < imageView.image.size.height) {
            CGFloat picH = imageView.image.size.height / imageView.image.size.width * kPhotoImageViewW*1.2;
            imageView.frame = CGRectMake(0, 0, kPhotoImageViewW*1.2, picH);
            photoContainerW = imageView.frame.size.width;
            photoContainerH = imageView.frame.size.height;
        }else {
            CGFloat picW = imageView.image.size.width / imageView.image.size.height * kPhotoImageViewW*1.2;
            imageView.frame = CGRectMake(0, 0, picW, kPhotoImageViewW*1.2);
            photoContainerW = imageView.frame.size.width;
            photoContainerH = imageView.frame.size.height;
        }
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }else if (picCount == 0){
        photoContainerW = 0;
        photoContainerH = 0;
    }else {// picCount = 1 2 3 5 6 7 8 9张
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
    
    CGRect lastFrame;
    if (_photoContainerViewFrame.size.height == 0) {
        lastFrame = self.contentLabelFrame;
    }else {
        lastFrame = self.photoContainerViewFrame;
    }
    
    //评论
    CGSize commentSize = [_model.numOfComment sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat commentX = ScreenWidth - commentSize.width - 15;
    CGFloat commentY = CGRectGetMaxY(lastFrame) + 13;
    _numOfCommentFrame = (CGRect){{commentX,commentY},commentSize};
    
    CGFloat commentImageX = CGRectGetMinX(_numOfCommentFrame) - 19;
    CGFloat commentImageY = CGRectGetMaxY(lastFrame) + 15;
    CGFloat commentImageW = 29/2;
    CGFloat commentImageH = 26/2;
    _commentImageFrame = (CGRect){{commentImageX,commentImageY},{commentImageW,commentImageH}};
    
    //点赞
    CGSize supportSize = [_model.numOfSupport sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    CGFloat supportX = CGRectGetMinX(_commentImageFrame) - 30 - supportSize.width;
    CGFloat supportY = CGRectGetMaxY(lastFrame) + 14;
    _numOfSupportFrame = (CGRect){{supportX,supportY},supportSize};
    
    CGFloat supportImageX = CGRectGetMinX(_numOfSupportFrame) - 19;
    CGFloat supportImageY = CGRectGetMaxY(lastFrame) + 15;
    CGFloat supportImageW = 28/2;
    CGFloat supportImageH = 27/2;
    _supportImageFrame = (CGRect){{supportImageX,supportImageY},{supportImageW,supportImageH}};
    
    
    self.cellHeight = CGRectGetMaxY(_numOfSupportFrame) + MARGIN+5;
}

@end
