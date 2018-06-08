//
//  draftsTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/2.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@class draftsModel;
@interface draftsTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView AndData:(draftsModel *)model;
@end
