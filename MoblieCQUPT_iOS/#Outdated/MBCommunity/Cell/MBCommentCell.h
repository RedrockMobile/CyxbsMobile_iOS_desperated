//
//  MBCommentCell.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCommunityTableView.h"
#import "MBCommentModel.h"
#import "MBComment_ViewModel.h"


@protocol MBCommentEventDelegate <NSObject>

@optional
- (void)commentEvenWhenClickHeadImageView:(MBCommentModel *)model;

@end

@interface MBCommentCell : UITableViewCell

@property (strong, nonatomic) MBCommentModel *model;
@property (strong, nonatomic) MBComment_ViewModel *viewModel;
@property (weak, nonatomic) id<MBCommentEventDelegate> eventDelegate;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *IDLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIView *underLine;

+ (instancetype)cellWithTableView:(MBCommunityTableView *)tableView;

@end
