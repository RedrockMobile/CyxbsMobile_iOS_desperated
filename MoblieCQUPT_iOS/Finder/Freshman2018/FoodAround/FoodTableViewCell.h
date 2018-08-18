//
//  FoodTableViewCell.h
//  迎新
//
//  Created by 陈大炮 on 2018/8/15.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *illstrateLabel;
@property (weak, nonatomic) IBOutlet UIButton *rankButton;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
