//
//  SYCMainPageView.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCMainPageView.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@interface SYCMainPageView()

@property (nonatomic, strong) UIImage *backgroundImage;

@end

@implementation SYCMainPageView

- (void)drawRect:(CGRect)rect{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *backgroudView = [[UIImageView alloc] initWithFrame:self.frame];
    backgroudView.image = [UIImage imageNamed:@"backgroud.jpg"];
    
    [self addSubview:backgroudView];
}
@end
