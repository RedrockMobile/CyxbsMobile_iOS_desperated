//
//  YouWenDetailHeadView.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/7.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouWenDeatilHeadViewBottomView.h"

@interface YouWenDetailHeadView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIView *picContainer;
@property (nonatomic, strong) YouWenDeatilHeadViewBottomView *bottomView;
@property (strong, nonatomic) UIImageView *imageview1;
@property (strong, nonatomic) UIImageView *imageview2;
@property (strong, nonatomic) UIImageView *imageview3;
@property (strong, nonatomic) UIImageView *imageview4;

- (instancetype)initWithNumOfPic:(int)num;
@end
