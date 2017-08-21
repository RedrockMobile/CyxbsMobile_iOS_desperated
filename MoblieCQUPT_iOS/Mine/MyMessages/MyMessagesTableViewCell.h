//
//  MyMessagesTableViewCell.h
//  Photo
//
//  Created by GQuEen on 16/5/10.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessagesTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *nicknameLabel;
@property (strong, nonatomic) UILabel *introductionLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
