//
//  YouWenDetailCell.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouWenDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *extendBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
//@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upvoteImageView;
@property (weak, nonatomic) IBOutlet UILabel *upvoteNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UIButton *adoptBtn;

@end
