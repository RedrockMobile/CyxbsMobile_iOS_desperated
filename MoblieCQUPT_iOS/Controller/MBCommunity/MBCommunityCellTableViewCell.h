//
//  MBCommunityCellTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCommunityModel.h"
#import "MBCommunity_ViewModel.h"
#import "MBPhotoContainerView.h"
#import "MBCommunityTableView.h"

@interface MBCommunityCellTableViewCell : UITableViewCell

@property (strong, nonatomic) MBCommunityModel *model;

@property (strong, nonatomic) UIImageView *headImageView;//头像
@property (strong, nonatomic) UILabel *IDLabel;//昵称
@property (strong, nonatomic) UILabel *timeLabel;//发送时间
@property (strong, nonatomic) UILabel *contentLabel;//内容

@property (strong, nonatomic) UIImageView *supportImage;//点赞图标
@property (strong, nonatomic) UIImageView *commentImage;//评论图标


@property (strong, nonatomic) UIButton *supportBtn;//点赞数
@property (strong, nonatomic) UIButton *commentBtn;//评论数

@property (strong, nonatomic) MBPhotoContainerView *photoContainer;

@property (strong, nonatomic) MBCommunity_ViewModel *subViewFrame;


+ (instancetype)cellWithTableView:(MBCommunityTableView *)tableView;
@end
