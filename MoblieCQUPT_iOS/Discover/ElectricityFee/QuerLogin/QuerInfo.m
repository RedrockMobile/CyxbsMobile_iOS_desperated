//
//  QuerInfo.m
//  Query
//
//  Created by hzl on 2017/3/16.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerInfo.h"

#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0

@implementation QuerInfo

- (void)drawRect:(CGRect)rect {
    UILabel *endlabel = [[UILabel alloc] init];
    [self maekLabel:endlabel WithText:@"电止度/度" fontOfSize:font(12) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] ];
    [self addSubview:endlabel];
    
    UILabel *startlabel = [[UILabel alloc] init];
    [self maekLabel:startlabel WithText:@"电起度/度" fontOfSize:font(12) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] ];
    [self addSubview:startlabel];
    
    UILabel *freelabel = [[UILabel alloc] init];
    [self maekLabel:freelabel WithText:@"月优惠量/度" fontOfSize:font(12) textColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] ];
    [self addSubview:freelabel];
}



- (void)drawElcEndLabelWithData:(NSString *)data{
    self.ElcEndLabel = [[UILabel alloc] init];
    [self maekLabel:self.ElcEndLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1]];
    [self addSubview:self.ElcEndLabel];
}

- (void)drawElcStartLabelWithData:(NSString *)data{
    self.ElcStartLabel = [[UILabel alloc] init];
    [self maekLabel:self.ElcStartLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1]];
    [self addSubview:self.ElcStartLabel];
}

- (void)drawFreeLabelWithData:(NSString *)data{
    self.freeElcLabel = [[UILabel alloc] init];
    [self maekLabel:self.freeElcLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1]];
    [self addSubview:self.freeElcLabel];
}

- (void)drawAveragELecWithData:(NSString *)data{
    self.avergaeElecLabel = [[UILabel alloc] init];
    [self maekLabel:self.avergaeElecLabel WithText:data fontOfSize:font(25) textColor:[UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1]];
    [self addSubview:self.avergaeElecLabel];
}



- (void)maekLabel:(UILabel *)label WithText:(NSString *)text fontOfSize:(CGFloat)size textColor:(UIColor *)color{
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
