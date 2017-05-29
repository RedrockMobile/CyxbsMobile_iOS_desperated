//
//  MyMessagesViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/10.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCommunityModel.h"
#import "MBCommentModel.h"

typedef NS_ENUM(NSInteger, MessagesViewLoadType) {
    MessagesViewLoadTypeSelf,
    MessagesViewLoadTypeOther
};

@interface MyMessagesViewController : UIViewController

@property (strong, nonatomic) MBCommunityModel *model;
@property (strong, nonatomic) MBCommentModel *commentModel;

- (instancetype)initWithLoadType:(MessagesViewLoadType)loadType;


//如果是社区点击头像 则使用一下初始化方法
- (instancetype)initWithLoadType:(MessagesViewLoadType)loadType withCommunityModel:(MBCommunityModel *)model;
//如果是详情里点击评论的头像 则使用一下初始化方法
- (instancetype)initWithLoadType:(MessagesViewLoadType)loadType withCommentModel:(MBCommentModel *)model;

@end
