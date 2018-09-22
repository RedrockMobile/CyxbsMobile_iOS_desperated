//
//  WYCShowDetailView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/22.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCShowDetailView.h"

@interface WYCShowDetailView()


@end

@implementation WYCShowDetailView

+(WYCShowDetailView *)initViewFromXib;
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"WYCShowDetailView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
}

- (void)initView{
    
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
