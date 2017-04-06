//
//  QuerNoteView.m
//  Query
//
//  Created by hzl on 2017/3/5.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerNoteView.h"
#import "AppDelegate.h"

#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){

    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleY;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@interface QuerNoteView ()

@end

@implementation QuerNoteView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawDateLabel];
    [self drawNoteLabel];
    [self drawTelInfoLabel];
    [self drawRecordTimeWithData:_recordStr];
}

- (void)drawRecordTimeWithData:(NSString *)data{
    UILabel *label = [[UILabel alloc] init];
    
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *compoent = [calendar components:NSCalendarUnitYear fromDate:currentDate];
    
    NSString *text = [NSString stringWithFormat:@"%ld年%@",(long)[compoent year],data];
    [self maekLabel:label WithText:text fontOfSize:font(13) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] frame:CHANGE_CGRectMake(94.5, 55, 100, 15)];
    [self addSubview:label];
}

- (void)drawTelInfoLabel{
    UILabel *label = [[UILabel alloc] init];
    NSMutableAttributedString *telInfoStr = [[NSMutableAttributedString alloc] initWithString:@"用电过程中如需查询，请致电 023-62487902" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font(13)]}];
    [telInfoStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:27/255.0 green:184/255.0 blue:250/255.0 alpha:1],NSBackgroundColorAttributeName:[UIColor clearColor]} range:NSMakeRange(0, 26)];
    [telInfoStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]} range:NSMakeRange(0,14)];
  
    label.frame = CHANGE_CGRectMake(31, 82, 265, 15);
    label.attributedText = telInfoStr;
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.contentMode = UIViewContentModeRedraw;
    [self addSubview:label];
}

- (void)drawDateLabel{
    UILabel *label = [[UILabel alloc] init];
    [self maekLabel:label WithText:@"抄表日期:" fontOfSize:font(13) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] frame:CHANGE_CGRectMake(31, 55 , 55, 15)];
    [self addSubview:label];
}

- (void)drawNoteLabel{
    UILabel *label = [[UILabel alloc] init];
    [self maekLabel:label WithText:@"注意事项" fontOfSize:font(14) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] frame:CHANGE_CGRectMake(31, 20, 55, 15)];
    [self addSubview:label];
}

- (void)maekLabel:(UILabel *)label WithText:(NSString *)text fontOfSize:(CGFloat)size textColor:(UIColor *)color frame:(CGRect)frame{
    label.frame = frame;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:size];
    label.adjustsFontSizeToFitWidth = YES;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.contentMode = UIViewContentModeRedraw;
}

@end
