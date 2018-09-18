//
//  ShowVideoRootView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ShowVideoRootView.h"
#import "ShowVideoScroll.h"

@implementation ShowVideoRootView

//@property (nonatomic, strong) ShowPicScroll *rollView;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(ShowVideoRootView *)instanceVideoView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShowVideoRootView" owner:nil options:nil];
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


-(void)addScrollViewWithArray:(NSArray *)dataArray{
    ShowVideoScroll *videoscroll = [[ShowVideoScroll alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 160*(SCREENHEIGHT/667)) withDistanceForScroll:20.0f*autoSizeScaleX withGap:20.0f*autoSizeScaleX];
    
    
    [videoscroll addScrollViewWithArray:dataArray];
    [self addSubview:videoscroll];
}


@end
