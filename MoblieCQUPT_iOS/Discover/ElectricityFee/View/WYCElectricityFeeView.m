//
//  WYCElectricityFeeView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/4/2.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import "WYCElectricityFeeView.h"
@interface WYCElectricityFeeView()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation WYCElectricityFeeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViewFromXib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadViewFromXib];
    }
    NSArray *titleArray = @[@"费用/月",@"日均量/度",@"电起度/度",@"电止度/度",@"月优惠量/度"];
    switch (self.tag) {
        case 0:
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"elecImg%li",self.tag]];
            self.titleLabel.text = titleArray[self.tag];
            break;
        case 1:
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"elecImg%li",self.tag]];
            self.titleLabel.text = titleArray[self.tag];
            break;
        case 2:
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"elecImg%li",self.tag]];
            self.titleLabel.text = titleArray[self.tag];
            break;
        case 3:
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"elecImg%li",self.tag]];
            self.titleLabel.text = titleArray[self.tag];
            break;
        case 4:
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"elecImg%li",self.tag]];
            self.titleLabel.text = titleArray[self.tag];
            break;
        case 5:
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"elecImg%li",self.tag]];
            self.titleLabel.text = titleArray[self.tag];
            break;
        default:
            break;
    }
    return self;
}

- (void)loadViewFromXib
{
    // 对于Bundle不太了解，但这里要用[NSBundle bundleForClass:[self class]]]取对对应的Bundle，而不是用mainBundle或者nil
    UIView *contentView = [[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    contentView.frame = self.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight;
    [self addSubview:contentView];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
