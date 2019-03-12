//
//  MineTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/18.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "MineTableViewCell.h"
#import <UIBezierPath+YYAdd.h>

@implementation MineTableViewCell

- (instancetype)initWithType:(MineCellType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect{
    if (_type == MineCellTypeNormal) {
        _backgroudView.layer.masksToBounds = YES;
        _backgroudView.layer.cornerRadius = 15.0;
    }else if(_type == MineCellTypeStart){
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backgroudView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15,15)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _backgroudView.bounds;
        maskLayer.path = maskPath.CGPath;
        _backgroudView.layer.mask = maskLayer;
    }else if (_type == MineCellTypeEnd){
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backgroudView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15,15)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _backgroudView.bounds;
        maskLayer.path = maskPath.CGPath;
        _backgroudView.layer.mask = maskLayer;
    }
}
    
@end
