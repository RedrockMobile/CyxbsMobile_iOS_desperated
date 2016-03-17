//
//  QGERestTimeDetailView.m
//  
//
//  Created by GQuEen on 12/18/15.
//
//

#import "QGERestTimeDetailView.h"

@implementation QGERestTimeDetailView

- (instancetype)initWithFrame:(CGRect)frame withDictionary:(NSDictionary *)dic {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadAlertView:dic];
    }
    return self;
}

- (void)loadAlertView:(NSDictionary *)dic {
    UIImageView *clockImg = [[UIImageView alloc]initWithFrame:CGRectMake(25, 25, 20, 20)];
    UIImageView *accountImg = [[UIImageView alloc]initWithFrame:CGRectMake(25, clockImg.frame.origin.y+clockImg.frame.size.height+20, 20, 20)];
    
    UILabel *clockLabel = [[UILabel alloc]initWithFrame:CGRectMake(clockImg.frame.origin.x+clockImg.frame.size.width+10, 25, 35, 20)];
    UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(accountImg.frame.origin.x+accountImg.frame.size.width+10, accountImg.frame.origin.y, 55, 20)];
    
    UILabel *clockInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(clockLabel.frame.origin.x+clockLabel.frame.size.width+15, 25, self.frame.size.width-clockImg.frame.size.width-10-clockLabel.frame.size.width-15-50, 20)];
    UILabel *accountInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(accountLabel.frame.origin.x+accountLabel.frame.size.width+15, accountImg.frame.origin.y, self.frame.size.width-clockImg.frame.size.width-10-clockLabel.frame.size.width-15-50, 20)];
    
    clockImg.image = [UIImage imageNamed:@"iconfont-clock.png"];
    accountImg.image = [UIImage imageNamed:@"iconfont-menuiconaccount.png"];
    
    clockLabel.text = @"时间";
    clockLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    accountLabel.text = @"小伙伴";
    accountLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    clockInfoLabel.text = [NSString stringWithFormat:@"%@  %@",dic[@"day"],dic[@"lesson"]];
    clockInfoLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    accountInfoLabel.text = [NSString stringWithFormat:@"共计%ld人",(unsigned long)((NSArray *)dic[@"names"]).count];
    accountInfoLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    
    [self addSubview:clockImg];
    [self addSubview:clockLabel];
    [self addSubview:clockInfoLabel];
    
    [self addSubview:accountImg];
    [self addSubview:accountLabel];
    [self addSubview:accountInfoLabel];
    
    UIScrollView *labelScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(25, accountImg.frame.origin.y+accountImg.frame.size.height+20, self.frame.size.width-50, self.frame.size.height-clockImg.frame.size.height-accountImg.frame.size.height-65)];
    
    UILabel *namesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelScroll.frame.size.width, labelScroll.frame.size.height)];
    namesLabel.clipsToBounds = YES;
    namesLabel.numberOfLines = 0;
    namesLabel.font = [UIFont systemFontOfSize:15];
    namesLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    NSArray *names = dic[@"names"];
    if (names.count > 0) {
        namesLabel.text = names[0];
        for (int i = 1; i < names.count; i ++) {
            namesLabel.text = [NSString stringWithFormat:@"%@    %@",namesLabel.text,names[i]];
        }
        [namesLabel sizeToFit];
    }
    [labelScroll addSubview:namesLabel];
    labelScroll.contentSize = CGSizeMake(labelScroll.frame.size.width, namesLabel.frame.size.height);
    labelScroll.showsVerticalScrollIndicator = NO;
    labelScroll.bounces = NO;
    [self addSubview:labelScroll];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
