//
//  ExamScheduleTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 2016/12/15.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamScheduleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *examName;
@property (weak, nonatomic) IBOutlet UILabel *examLocation;
@property (weak, nonatomic) IBOutlet UILabel *examTime;
@property (weak, nonatomic) IBOutlet UILabel *examDate;

@end
