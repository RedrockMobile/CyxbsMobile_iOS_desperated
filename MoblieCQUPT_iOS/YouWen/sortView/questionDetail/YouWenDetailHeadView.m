//
//  YouWenDetailHeadView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/7.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenDetailHeadView.h"
#import <Masonry.h>

@interface YouWenDetailHeadView()




@end

@implementation YouWenDetailHeadView


- (instancetype)initWithNumOfPic:(int)num {
    
    self = [super init];
    
    if (self) {
        self.frame = CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT);
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(16);
            make.top.equalTo(self.mas_top).offset(17);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.text = @"线代第一题不会。求解。公式应该没问题，算了几次不正确";
        
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.numberOfLines = 0;
        [self addSubview:self.descriptionLabel];
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left).offset(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
            make.right.equalTo(self.titleLabel.mas_right).offset(0);
        }];
        self.descriptionLabel.font = [UIFont systemFontOfSize:14];
        self.descriptionLabel.text = @"阿瑟费大事发生地方 v 是大丰收地方阿凡达沙发床上吃饭撒撒点出发城市地方擦色的付出阿双方达成FC饿啊我说的付出为";
        
        
        self.picContainer = [[UIView alloc] init];
        [self addSubview:self.picContainer];
        
        if (num == 0) {
            [self.picContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.descriptionLabel.mas_bottom).offset(10);
                make.left.mas_equalTo(self.titleLabel.mas_left);
                make.right.mas_equalTo(self.titleLabel.mas_right);
                make.height.mas_equalTo(@1);
            }];
            
        } else if (num == 1) {
            [self.picContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.descriptionLabel.mas_bottom).offset(10);
                make.left.mas_equalTo(self.titleLabel.mas_left);
                make.right.mas_equalTo(self.titleLabel.mas_right);
                make.height.mas_equalTo(@(162/667.0*SCREENHEIGHT));
            }];
            
            self.imageview1 = [[UIImageView alloc] init];
            [self.picContainer addSubview:self.imageview1];
            [self.imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.equalTo(self.picContainer);
            }];
             
            
        } else if (num == 2) {
            [self.picContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.descriptionLabel.mas_bottom).offset(10);
                make.left.mas_equalTo(self.titleLabel.mas_left);
                make.right.mas_equalTo(self.titleLabel.mas_right);
                make.height.mas_equalTo(@(102/667.0*SCREENHEIGHT));
            }];
            
            self.imageview1 = [[UIImageView alloc] init];
            self.imageview2 = [[UIImageView alloc] init];
            [self.picContainer addSubview:self.imageview1];
            [self.picContainer addSubview:self.imageview2];
            NSArray<UIImageView *> *views = @[self.imageview1, self.imageview2];
            
            UIView *lastView;
            for (UIView *view in views) {
                
                if (lastView) {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(lastView.mas_right).offset(9);
                        make.bottom.top.equalTo(lastView);
                        make.width.equalTo(lastView);
                    }];
                } else {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.left.equalTo(self.picContainer);
                    }];
                }
                
                lastView = view;
            }
            
            [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.picContainer);
            }];
            
        } else {
            [self.picContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.descriptionLabel.mas_bottom).offset(10);
                make.left.mas_equalTo(self.titleLabel.mas_left);
                make.right.mas_equalTo(self.titleLabel.mas_right);
                make.height.mas_equalTo(@(214/667.0*SCREENHEIGHT));
            }];
            
            self.imageview1 = [[UIImageView alloc] init];
            self.imageview2 = [[UIImageView alloc] init];
            self.imageview3 = [[UIImageView alloc] init];
            self.imageview4 = [[UIImageView alloc] init];
            [self.picContainer addSubview:self.imageview1];
            [self.picContainer addSubview:self.imageview2];
            [self.picContainer addSubview:self.imageview3];
            [self.picContainer addSubview:self.imageview4];
            
            if (num == 3) {
                self.imageview4 = nil;
                
                [self.imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.equalTo(self.picContainer);
                }];
                
                [self.imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.imageview1.mas_right).offset(10);
                    make.top.right.equalTo(self.picContainer);
                    make.width.equalTo(self.imageview1);
                }];
                
                [self.imageview3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.equalTo(self.picContainer);
                    make.top.equalTo(self.imageview1.mas_bottom).offset(10);
                    make.width.equalTo(self.imageview1);
                    make.height.equalTo(self.imageview1);
                }];
                
                [self.imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.imageview1);
                }];
                
            } else if (num == 4) {
                [self.imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.equalTo(self.picContainer);
                }];
                
                [self.imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.imageview1.mas_right).offset(9);
                    make.top.right.equalTo(self.picContainer);
                    make.width.equalTo(self.imageview1);
                }];
                
                [self.imageview3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.equalTo(self.picContainer);
                    make.top.equalTo(self.imageview1.mas_bottom).offset(10);
                    make.height.equalTo(self.imageview1);
                }];
                
                [self.imageview4 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.imageview3.mas_right).offset(10);
                    make.right.equalTo(self.picContainer);
                    make.width.equalTo(self.imageview3);
                    make.top.equalTo(self.imageview2.mas_bottom).offset(10);
                    make.bottom.equalTo(self.picContainer);
                    make.height.equalTo(self.imageview2);
                }];
            }
            
        }
        
        
        [self.picContainer layoutIfNeeded];
        //tableHeaderView下面的阴影
        self.bottomView = [[YouWenDeatilHeadViewBottomView alloc] init];
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.equalTo(self.picContainer.mas_bottom).offset(10);
            make.height.mas_equalTo(@(76/667.0*[UIScreen mainScreen].bounds.size.height));
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        self.bottomView.avatarImageView.clipsToBounds = YES;
        self.bottomView.avatarImageView.layer.cornerRadius = self.bottomView.avatarImageView.frame.size.width/2.0;
//        [self mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.bottomView.mas_bottom);
//        }];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
