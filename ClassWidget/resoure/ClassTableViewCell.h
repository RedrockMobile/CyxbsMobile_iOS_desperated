//
//  ClassTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by user on 15/12/16.
//  Copyright © 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *classroomLabel;
@property (weak, nonatomic) IBOutlet UILabel *classTimeLabel;

@end
