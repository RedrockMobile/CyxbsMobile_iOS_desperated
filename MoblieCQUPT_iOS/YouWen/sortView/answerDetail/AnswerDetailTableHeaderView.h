//
//  AnswerDetailTableHeaderView.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/3.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YouWenAnswerDetailModel;

@interface AnswerDetailTableHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIView *bottomGrayView;
@property (weak, nonatomic) IBOutlet UIButton *adoptBtn;
- (instancetype) initWithModel:(YouWenAnswerDetailModel *)model;

@end
