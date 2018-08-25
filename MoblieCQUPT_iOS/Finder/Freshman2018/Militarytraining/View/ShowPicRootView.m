//
//  ShowPicRootView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ShowPicRootView.h"
#import "ShowPicScroll.h"



@implementation ShowPicRootView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+(ShowPicRootView *)instancePicView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShowPicRootView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, 240*(SCREENHEIGHT/667));
        
    }
    return self;
}


-(void)addScrollView:(NSArray *)data{
    
    ShowPicScroll *picscrollview  = [[ShowPicScroll alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 160*(SCREENHEIGHT/667)) withDistanceForScroll:12.0f withGap:8.0f];
    
    
    
    [picscrollview addScrollViewWithArray:data];
    [self addSubview:picscrollview];
//   
}

@end
