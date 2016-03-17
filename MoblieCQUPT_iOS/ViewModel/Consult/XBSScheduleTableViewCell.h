//
//  ScheduleTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/27/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBSScheduleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *examTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeIcon;
@property (weak, nonatomic) IBOutlet UILabel *locationIcon;
@property (weak, nonatomic) IBOutlet UILabel *examTime;
@property (weak, nonatomic) IBOutlet UILabel *examLocation;

@end
