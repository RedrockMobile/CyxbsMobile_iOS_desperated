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

typedef void(^ClickSupportBtnBlock)(UIButton *imageBtn,UIButton *labelBtn,MBCommunity_ViewModel *viewModel);


@protocol MBCommunityCellEventDelegate <NSObject>

@optional
- (void)eventWhenclickHeadImageView:(MBCommunityModel *)model;

@end

@interface MBCommunityCellTableViewCell : UITableViewCell

@property (strong, nonatomic) MBCommunityModel *model;

@property (weak, nonatomic) id<MBCommunityCellEventDelegate> eventDelegate;

@property (strong, nonatomic) UIImageView *headImageView;//头像
@property (strong, nonatomic) UILabel *IDLabel;//昵称
@property (strong, nonatomic) UILabel *timeLabel;//发送时间
@property (strong, nonatomic) UILabel *contentLabel;//内容

//@property (strong, nonatomic) UIImageView *supportImage;//点赞图标
@property (strong, nonatomic) UIImageView *commentImage;//评论图标

@property (strong, nonatomic) UIButton *supportImage;
@property (strong, nonatomic) UIButton *supportBtn;//点赞数
@property (strong, nonatomic) UIButton *commentBtn;//评论数

@property (strong, nonatomic) MBPhotoContainerView *photoContainer;

@property (strong, nonatomic) MBCommunity_ViewModel *subViewFrame;

@property (copy, nonatomic) ClickSupportBtnBlock clickSupportBtnBlock;


+ (instancetype)cellWithTableView:(MBCommunityTableView *)tableView;
@end
