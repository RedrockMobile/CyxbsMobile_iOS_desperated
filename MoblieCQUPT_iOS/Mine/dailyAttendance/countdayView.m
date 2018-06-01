//
//  countdayView.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/19.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "countdayView.h"
@interface countdayView()

@property (strong, nonatomic) IBOutletCollection (UIImageView) NSArray *bluePoint;
@property (strong, nonatomic) IBOutletCollection (UILabel) NSArray *dayLabel;
@property (strong, nonatomic)
    IBOutletCollection(UILabel) NSArray *soreLabel;
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
    NSInteger num = [day integerValue] - 2;
    for (int i = 0; i <= 4;  i++ ) {
        UIImageView *imgV = _bluePoint[i];
        UILabel *dayL = _dayLabel[i];
        UILabel *soreL = _soreLabel[i];
        
        
        if (imgV.tag < num){
            imgV.hidden = NO;
        }
        else {
            imgV.hidden = YES;
        }
        if (dayL.tag < num){
            dayL.textColor = [UIColor blackColor];
        }
        else {
            dayL.textColor = [UIColor grayColor];
        }
        if (soreL.tag < num){
            soreL.textColor = [UIColor blackColor];
        }
        else {
            soreL.textColor = [UIColor grayColor];
        }
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
