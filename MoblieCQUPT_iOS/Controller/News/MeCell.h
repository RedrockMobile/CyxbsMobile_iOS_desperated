//
//  MeCell.h
//  重邮小帮手
//
//  Created by 1808 on 15/8/19.
//  Copyright (c) 2015年 1808. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *toplable;
@property (weak, nonatomic) IBOutlet UILabel *daylable;

@property (weak, nonatomic) IBOutlet UIView *backview;
@property (weak, nonatomic) IBOutlet UILabel *specificlable;

@end
