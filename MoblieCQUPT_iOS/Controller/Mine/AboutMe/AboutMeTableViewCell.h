//
//  AboutMeTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/4/21.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *createdTime;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *articleContent;
@property (weak, nonatomic) IBOutlet UIImageView *articlePhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articlePhotoWidth;

@end