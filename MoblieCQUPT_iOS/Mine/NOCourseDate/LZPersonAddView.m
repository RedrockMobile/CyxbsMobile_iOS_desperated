//
//  LZPersonAddView.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/21.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZPersonAddView.h"
@interface LZPersonAddView()
@property UILabel *titleLabel;
@property UIImageView *cancelImageView;
@end


@implementation LZPersonAddView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        self.titleLabel = [[UILabel alloc]initWithFrame:frame];
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.borderColor = [UIColor colorWithHexString:@"788EFA"].CGColor;
        [self.titleLabel setTextColor:[UIColor colorWithHexString:@"788EFA"]];
        self.cancelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/4, frame.size.width/4)];
        self.cancelImageView.center = CGPointMake(frame.size.width, 0);
        self.cancelImageView.image = [UIImage imageNamed:@"date_image_cancel"];
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
