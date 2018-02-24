//
//  YouWenTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouWenTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView andDic:(NSDictionary *)dic;
/*
    sore:积分 sort:类型 gender:性别   name:名字
    title:标题 detail:文章
 */
@property (copy, nonatomic) NSDictionary *dataDic;
@property (assign, nonatomic) CGRect cellSize;
@end
