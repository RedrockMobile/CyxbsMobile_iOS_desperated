//
//  AboutMePraiseTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/8.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMePraiseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *createdTime;
@property (weak, nonatomic) IBOutlet UIImageView *articlePhoto;
@property (weak, nonatomic) IBOutlet UILabel *articleContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articlePhotoWidth;

@end
