//
//  TransparentView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/8.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "TransparentView.h"
@implementation TransparentView
- (instancetype)initTheWhiteViewHeight:(CGFloat)height{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        [self setSelf];
        [self setUpWhiteView:height];

    }
    return self;
}
- (instancetype)initWithNews:(NSArray *)array{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        [self setSelf];
        [self setUpMessage:array];
    }
    return self;
}
- (void)setSelf{
    self.backgroundColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:0.8];
    self.enableBack = YES;
    UITapGestureRecognizer *touchBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [touchBack setNumberOfTapsRequired:1];
    [self addGestureRecognizer:touchBack];
    
}

- (void)back{
    [self removeFromSuperview];
}
- (void)setEnableBack:(BOOL)enableBack{
    _enableBack = enableBack;
    if (self.enableBack) {
        self.userInteractionEnabled = YES;
    }
    else{
        self.userInteractionEnabled = NO;
    }
}

- (void)setUpWhiteView:(CGFloat)height{
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, height)];
    [UIView animateWithDuration:0.5 animations:^{
        _whiteView.centerY = ScreenHeight - height / 2;
    }];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
}

- (void)setUpMessage:(NSArray *)array{
   NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect1 = [array[2] boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesLineFragmentOrigin
        |NSStringDrawingUsesFontLeading
        attributes:dic context:nil];
    CGRect rect2 = [array[3] boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGFloat width = rect1.size.width > rect2.size.width?rect1.size.width:rect2.size.width;
    _squareBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squareBox"]];
    //否则btn不响应
    _squareBox.userInteractionEnabled = YES;
    [self addSubview:_squareBox];
    [_squareBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-10);
        make.top.mas_equalTo(self).mas_offset(64);
        make.width.mas_offset(96);
        make.height.mas_offset(84);
    }];
    
    for (int i = 0; i < array.count / 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [_squareBox addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_squareBox);
            make.left.mas_equalTo(_squareBox);
            make.height.mas_offset(_squareBox.height / 2);
            if (i == 0) {
                make.top.mas_equalTo(_squareBox);
            }
            else {
                make.bottom.mas_equalTo(_squareBox);
            }
        }];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array[i]]];
        [btn addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btn).mas_offset(10);
            make.centerY.mas_equalTo(btn);
            make.width.mas_offset(15);
            make.height.mas_offset(15);
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = array[i + 2];
        lab.font = [UIFont fontWithName:@"Arial" size:13];
        lab.textColor = [UIColor colorWithHexString:@"7496FA"];
        lab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right)
            .mas_offset(10);
            make.centerY.mas_equalTo(btn);
            make.width.mas_offset(width);
            make.height.mas_offset(15);
        }];
    }
}

- (void)btnAction:(UIButton *)btn{
    [self removeFromSuperview];
    [self.delegate newView:btn];
}
//不传递
-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == _whiteView||hitView == _squareBox) {
        return nil;
    } else {
        return hitView;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
