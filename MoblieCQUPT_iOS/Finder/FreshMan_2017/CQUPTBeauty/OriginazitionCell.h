//
//  OriginazitionCell.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OriginazitionCell : UITableViewCell
@property(strong, nonatomic) UILabel *namesLabel;
@property(strong, nonatomic) UILabel *detailLabel;
@property(strong, nonatomic) UIView *cutLine;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
