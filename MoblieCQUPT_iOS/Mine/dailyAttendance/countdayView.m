//
//  countdayView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/19.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "countdayView.h"
@interface countdayView()
@property (weak, nonatomic) IBOutletCollection (UIImageView) NSArray<UIImageView *> *bluePoint;
@property (weak, nonatomic) IBOutletCollection (UILabel) NSArray<UILabel  *> *dayLabel;
@property (weak, nonatomic)
IBOutletCollection(UILabel) NSArray<UILabel *> *soreLabel;
@end
@implementation countdayView
- (id)initWithFrame:(CGRect)frame AndDay:(NSString *)day{
    self = [[NSBundle mainBundle] loadNibNamed:@"countdayView" owner:self options:nil][0];
    if (self){
        self.frame = frame;
        [self selectDay:day];
    }
    return self;
}
- (void)selectDay:(NSString *)day{
    NSUInteger num = [day integerValue];
    for (int i = 0; i <= 4;  i++ ) {
        _bluePoint[i].hidden = YES;
        _dayLabel[i].textColor = [UIColor blackColor];
        _soreLabel[i].textColor = [UIColor blackColor];
    }
    for (int i = 0; i < num;  i++ ) {
        _bluePoint[i].hidden = NO;
    }
    _dayLabel[num].textColor = [UIColor blackColor];
    _soreLabel[num].textColor = [UIColor blackColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
