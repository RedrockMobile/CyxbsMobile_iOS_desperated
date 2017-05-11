//
//  MBNews_ViewModel.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/8/18.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MBNewsModel.h"
#import "MBCommunityModel.h"

@interface MBNews_ViewModel : NSObject

@property (strong, nonatomic)  MBCommunityModel *model;

@property (assign, nonatomic) CGRect headImageViewFrame;//头像的frame
@property (assign, nonatomic) CGRect IDLabelFrame;//昵称的frame
@property (assign, nonatomic) CGRect timeLabelFrame;//发送时间的frame
@property (assign, nonatomic) CGRect contentLabelFrame;//内容的frame

@property (assign, nonatomic) CGRect numOfSupportFrame;//点赞的frame
@property (assign, nonatomic) CGRect numOfCommentFrame;//评论的frame
@property (assign, nonatomic) CGRect commentImageFrame;
@property (assign, nonatomic) CGRect supportImageFrame;

@property (assign, nonatomic) CGRect photoContainerViewFrame;
@property (assign, nonatomic) CGFloat cellHeight;//cell的高度

@end
