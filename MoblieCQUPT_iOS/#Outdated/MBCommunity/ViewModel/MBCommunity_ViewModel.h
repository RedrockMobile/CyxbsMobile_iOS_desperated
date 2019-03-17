//
//  MBCommunity_ViewModel.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBCommunityModel.h"
//#import "MBPhotoContainerView.h"
@interface MBCommunity_ViewModel : NSObject
@property (strong, nonatomic) MBCommunityModel *model;

@property (assign, nonatomic) CGRect headImageViewFrame;//头像的frame
@property (assign, nonatomic) CGRect IDLabelFrame;//昵称的frame
@property (assign, nonatomic) CGRect timeLabelFrame;//发送时间的frame
@property (assign, nonatomic) CGRect contentLabelFrame;//展开内容的frame
@property (assign, nonatomic) CGRect coverContentLabelFrame;//收缩内容的frame
/*
@property (assign, nonatomic) CGRect numOfSupportFrame;//点赞的frame
@property (assign, nonatomic) CGRect numOfCommentFrame;//评论的frame
 */
@property (assign, nonatomic) CGRect photoContainerViewFrame;
@property (assign, nonatomic) CGFloat cellHeight;//cell的高度

@property (assign, nonatomic) CGFloat extend_cellHeight;//展开cell高度
/*
@property (assign, nonatomic) CGRect commentImageFrame;
@property (assign, nonatomic) CGRect supportImageFrame;
*/


@property (assign, nonatomic) CGRect detailContentLabelFrame;//内容的frame
/*
@property (assign, nonatomic) CGRect detailNumOfSupportFrame;//点赞的frame
@property (assign, nonatomic) CGRect detailNumOfCommentFrame;//评论的frame
@property (assign, nonatomic) CGRect detailCommentImageFrame;
@property (assign, nonatomic) CGRect detailSupportImageFrame;
 */
@property (assign, nonatomic) CGFloat detailCellHeight;

@property (assign, nonatomic) CGRect detailPhotoContainerViewFrame;

//展开按钮 点赞 评论数
@property (assign, nonatomic) CGRect extendLabelFrame;
@property (assign, nonatomic) CGRect dottedLineImageViewFrame;
@property (assign, nonatomic) CGRect upvotebtnFrame;
@property (assign, nonatomic) CGRect numOfUpvoteFrame;
@property (assign, nonatomic) CGRect commentImageviewFrame;
@property (assign, nonatomic) CGRect numOfCommentFrame;

//展开后的 contentLabel 展开按钮 点赞 评论数
@property (assign, nonatomic) CGRect extend_contentLabelFrame;
@property (assign, nonatomic) CGRect extend_extendLabelFrame;
@property (assign, nonatomic) CGRect extend_dottedLineImageViewFrame;
@property (assign, nonatomic) CGRect extend_upvotebtnFrame;
@property (assign, nonatomic) CGRect extend_numOfUpvoteFrame;
@property (assign, nonatomic) CGRect extend_commentImageviewFrame;
@property (assign, nonatomic) CGRect extend_numOfCommentFrame;
@property (assign, nonatomic) CGRect extend_photoContainerViewFrame;

@end
