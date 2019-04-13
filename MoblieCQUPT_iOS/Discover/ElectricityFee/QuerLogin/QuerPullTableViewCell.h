//
//  QuerPullTableViewCell.h
//  Query
//
//  Created by hzl on 2017/3/7.
//  Copyright © 2017年 c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuerPullTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *guideLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
