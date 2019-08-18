//
//  ZJshopTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 周杰 on 2017/11/20.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJshopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopDetailImage;
@property (weak, nonatomic) IBOutlet UILabel *shopDetailText;


@end
