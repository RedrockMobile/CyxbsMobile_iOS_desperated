//
//  LZPersonAddView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/24.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZPersonAddView.h"
@interface LZPersonAddView()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, readwrite)LZPersonAddViewType type;
@end
@implementation LZPersonAddView
- (instancetype)initWithFrame:(CGRect)frame type:(LZPersonAddViewType)type{
    self.type = type;
    if (type == LZPersonShow) {
        self = [self initWithFrame:frame];
    }
    else{
        self = [super initWithFrame:frame];
        if (self) {
            self.addBtn = [[UIButton alloc]init];
            self.addBtn.layer.cornerRadius = 2;
            [self.addBtn setBackgroundImage:[UIImage imageNamed:@"date_image_add"] forState:UIControlStateNormal];
            [self addSubview:self.addBtn];
            [self.addBtn addTarget:self action:@selector(addPerson) forControlEvents:UIControlEventTouchUpInside];
            self.addBtn.layer.borderWidth = 1;
            self.addBtn.layer.borderColor = [UIColor colorWithHexString:@"788EFA"].CGColor;
            [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.top.mas_equalTo(16/2);
                make.right.mas_equalTo(-16/2);
            }];
        }
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.cancelBtn = [[UIButton alloc]init];
        
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.cornerRadius = 2;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.layer.borderColor = [UIColor colorWithHexString:@"788EFA"].CGColor;
        [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"date_image_cancel"] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"788EFA"];
        [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.cancelBtn];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16/2);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-16/2);
        }];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.titleLabel.mas_right);
            make.centerY.mas_equalTo(self.titleLabel.mas_top);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(16);
        }];
    }
    return self;
}

- (void)cancel{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)addPerson{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (NSString *)title{
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
