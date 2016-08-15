//
//  BeautyCquptTableViewCell.h
//  FreshManFeature
//
//  Created by hzl on 16/8/12.
//  Copyright © 2016年 李展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyCquptTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIImageView *introduceImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
