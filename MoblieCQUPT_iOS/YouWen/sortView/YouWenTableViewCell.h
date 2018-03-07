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
    "title": 标题
    "description": 描述,
    "kind":
    "tags": "PHP",
    "reward": 1,
    "answer_num": 1,
    "disappear_at": "2018-02-08 01:11:20",
    "created_at": "2018-02-08 04:21:50",
    "is_anonymous": 1,
    "id": 5,
    "photo_thumbnail_src": null,
    "nickname": "匿名用户",
    "photo_url":
 */
@property (copy, nonatomic) NSDictionary *dataDic;
@property (assign, nonatomic) CGRect cellSize;
@end
