//
//  BeautyCreatTableViewCell.h
//  FreshManFeature
//
//  Created by hzl on 16/8/11.
//  Copyright © 2016年 李展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyCreatTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *idLabel;
@property (strong, nonatomic) UIImageView *videoView;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UILabel *introduceLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
