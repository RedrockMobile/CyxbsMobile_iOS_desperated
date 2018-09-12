//
//  BankTableViewCell.h
//  迎新
//
//  Created by 陈大炮 on 2018/8/17.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankAddress;

@end
