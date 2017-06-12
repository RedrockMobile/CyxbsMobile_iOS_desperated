//
//  HZLShareView.m
//  MoblieCQUPT_iOS
//
//  Created by hzl on 2017/6/6.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "HZLShareView.h"
#import "ImageWithLabel.h"

@interface HZLShareView()
//所有标题
@property (nonatomic, strong) NSArray *shareBtnTitleArray;

//所有图片
@property (nonatomic, strong) NSArray *shareBtnImageArray;

//分享面板
@property (nonatomic, strong) UIView *shareView;

//取消按钮
@property (nonatomic, strong) UIButton *cancleBtn;

//提示文字
@property (nonatomic, strong) UILabel *proLable;

//所有分享按钮
@property (nonatomic, strong) NSMutableArray *buttons;

//面板
@property (nonatomic, strong) UIView *topSheetView;

//话题标题
@property (nonatomic, strong) UILabel *titleLabel;

//背景图片
@property (nonatomic, strong) UIImageView *headImageView;

@property CALayer *colorLayer;

@end

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}


@implementation HZLShareView

#pragma mark ----- 懒加载
- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc] init];
        
        NSInteger index;
        if (_shareBtnTitleArray.count % 3 == 0) {
            index = _shareBtnTitleArray.count / 3;
        }else{
            index = _shareBtnTitleArray.count / 3 + 1;
        }
        _shareView.frame = CHANGE_CGRectMake(30, 667 , 315, 400);
    }
    return _shareView;
}

- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 315, 200)];
        _headImageView.backgroundColor = [UIColor clearColor];
        self.colorLayer = [CALayer layer]
        ;
        self.colorLayer.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.25].CGColor;
        self.colorLayer.frame = _headImageView.bounds;
        [_headImageView.layer addSublayer:self.colorLayer];
    }
    return _headImageView;
}

- (UIView *)topSheetView{
    if (!_topSheetView) {
        _topSheetView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 315, 350)];
        _topSheetView.backgroundColor = [UIColor whiteColor];
    }
    return _topSheetView;
}

- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CHANGE_CGRectMake(0, 350, 315, 50);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        [_cancleBtn setTitleColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray arrayWithCapacity:5];
    }
    return _buttons;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UIView *lineView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 55, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1];
        _titleLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(20, 150, 315, 50)];
        _titleLabel.font = [UIFont systemFontOfSize:font(24)];
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel addSubview:lineView];
    }
    return _titleLabel;
}

- (UILabel *)proLable{
    if (!_proLable) {
        _proLable = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(0, 15, 100, 20)];
        _proLable.font = [UIFont systemFontOfSize:font(12)];
        _proLable.text = @"分享话题";
        _proLable.textAlignment = NSTextAlignmentCenter;
        _proLable.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.3];
        _proLable.textColor = [UIColor whiteColor];
        _proLable.layer.cornerRadius = _proLable.frame.size.height/2.0;
        _proLable.layer.masksToBounds = YES;
    }
    return _proLable;
}

#pragma mark --- 初始化相关方法

- (instancetype)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArray:(NSArray *)imageArray andTopic:(NSString *)topicStr andImage:(UIImage *)bgImage{
    self = [super init];
    if (self) {
        self.shareBtnTitleArray = [NSArray arrayWithArray:titleArray];
        self.shareBtnImageArray = [NSArray arrayWithArray:imageArray];
        self.headImageView.image = bgImage;
        self.titleLabel.text = topicStr;
        
        self.frame = CHANGE_CGRectMake(0, 0, 375, 667);
        
        self.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.7];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        
        [self addGestureRecognizer:tapGesture];
        
        [self loadUIConfig];
    }
    return self;
}

- (void)loadUIConfig{
    [self.topSheetView addSubview:self.headImageView];
    [self.topSheetView addSubview:self.proLable];
    [self.topSheetView addSubview:self.titleLabel];
    [self.topSheetView addSubview:self.cancleBtn];
    [self.shareView addSubview:self.topSheetView];
    
    [self addSubview:self.shareView];
    
    //创建分享按钮
    for (NSInteger i = 0; i < self.shareBtnTitleArray.count; i++) {
        CGFloat x = self.shareView.size.width / 2.5 * (i % 3);
        CGFloat y = 150 * autoSizeScaleY + (i / 3) * 70 * autoSizeScaleY;
        CGFloat w = 60 * autoSizeScaleX;
        CGFloat h = 60 * autoSizeScaleY;
        
        CGRect frame = CGRectMake(x, y, w, h);
        ImageWithLabel *item = [ImageWithLabel imageLabelWithFrame:frame Image:[UIImage imageNamed:self.shareBtnImageArray[i]] LabelText:self.shareBtnTitleArray[i]];
        item.labelOffsetX = 6;
        item.labelOffsetY = 10;
        
        item.tag = 200 + i;
        UITapGestureRecognizer *taoGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
        [item addGestureRecognizer:taoGesture];
        [self.topSheetView addSubview:item];
        
        [self.buttons addObject:item];
    }
    //弹出
    [UIView animateWithDuration:0.3 animations:^{
        self.shareView.frame = CHANGE_CGRectMake(30, 200, 315, 400);
    }];
    [self iconAdd];
}

- (void)iconAdd {

    for (UIView *icon in self.buttons) {
        CGRect frame = icon.frame;
        frame.origin.y += frame.size.height;
        icon.frame = frame;
        icon.clipsToBounds = YES;
        [self.topSheetView addSubview:icon];
    }
}

- (void)tappedCancel{
    [UIView animateWithDuration:0.3 animations:^{
        [self.shareView setFrame:CHANGE_CGRectMake(30, 667, 315, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)itemClick:(UITapGestureRecognizer *)tapGes{
    [self tappedCancel];
    if (self.shareClick) {
        self.shareClick(tapGes.view.tag - 200);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.colorLayer.frame = self.headImageView.bounds;
    
//    self.labelLayer = [CAShapeLayer createMaskLayerWithView:self.numLabel];
//    self.numLabel.layer.mask = self.labelLayer;
}

@end
