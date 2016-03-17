//
//  PickView.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickView : UIView
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *timeImage;
@property (strong, nonatomic) UIImageView *classImage;
@property (strong, nonatomic) UIImageView *sectionImage;
@property (strong, nonatomic) UIView *line1;
@property (strong, nonatomic) UIView *line2;
@property (strong, nonatomic) UIView *line3;

@property (strong, nonatomic) UIButton *timeBtn;
@property (strong, nonatomic) UIButton *classBtn;
@property (strong, nonatomic) UIButton *sectionBtn;

@property (strong, nonatomic) UIImageView *tag1;
@property (strong, nonatomic) UIImageView *tag2;
@property (strong, nonatomic) UIImageView *tag3;

@property (strong, nonatomic) UIButton *searchBtn;

@property (assign, nonatomic) CGFloat margin;
@property (assign, nonatomic) CGFloat margin1;
@property (assign, nonatomic) CGFloat imageWidth;
@property (assign, nonatomic) CGFloat fontSize;


- (void)updateBtnFrame;


@end
