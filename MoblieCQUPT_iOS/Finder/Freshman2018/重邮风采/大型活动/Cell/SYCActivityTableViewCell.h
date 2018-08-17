//
//  SYCActivityTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCActivityModel.h"

@interface SYCActivityTableViewCell : UITableViewCell

@property (nonatomic, strong)SYCActivityModel *activity;

@property (nonatomic)NSUInteger row;

@end
