//
//  ReportSortButton.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ReportSortButton.h"

@implementation ReportSortButton
- (id)initWithFrame:(CGRect)frame someWord:(NSString *)str{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpImage];
        [self setUptheWord:str];
    }
    return self;
}

-(void)setUpImage{
    self.imageView.contentMode = UIViewContentModeCenter;
    [self setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"selectcircle"] forState:UIControlStateSelected];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
}
- (void)setUptheWord:(NSString *)str{
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitle:str forState:UIControlStateNormal];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
