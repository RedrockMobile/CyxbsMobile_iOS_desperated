//
//  BeforeClassCell.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/12.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeforeClassCell : UITableViewCell
@property (strong, nonatomic)NSString *nameString;
@property (strong, nonatomic)NSString *detailString;
@property (assign, nonatomic)BOOL state;
+ (instancetype)cellWithTableView:(UITableView *)tableView AndStyle:(NSString *)style;
@end
