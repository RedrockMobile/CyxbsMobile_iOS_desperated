//
//  XBSFindClassroomPeriodView.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/12/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSFindClassroomPeriodView.h"
#import "UIColor+BFPaperColors.h"
#define ImageNameGroup @[@"8oClock", @"10oClock", @"2oClock", @"4oClock", @"7oClock", @"9oClock"]
#define SelectedColor [UIColor paperColorBlue700]
@implementation XBSFindClassroomPeriodView

- (instancetype)initWithIndex:(NSInteger)index{
    self = [[XBSFindClassroomPeriodView alloc]initWithFrame:CGRectMake(0, 108, ScreenWidth / 6 + 25, ScreenWidth / 6)];
    self.index = index;
    
    self.image                     = [[UIImage imageNamed:ImageNameGroup[index]]
                                      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView                 = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.backgroundColor = MAIN_COLOR;
    self.imageView.tintColor       = [UIColor whiteColor];
    self.imageView.frame           = CGRectMake(ScreenWidth / 6 * index, 0, ScreenWidth / 6, ScreenWidth / 6 + 1);
    
    self.label                     = [[UILabel alloc]init];
    self.label.backgroundColor     = MAIN_COLOR;
    self.label.textAlignment       = NSTextAlignmentCenter;
    self.label.text                = [NSString stringWithFormat:@"%ld~%ld", index * 2 + 1, index * 2 + 2];
    self.label.textColor           = [UIColor whiteColor];
    self.label.frame               = CGRectMake(ScreenWidth / 6 * index, ScreenWidth / 6, ScreenWidth / 6 + 1, 25);
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:self.tap];
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)gesture  {
    //NSLog(@"%ld",((XBSFindClassroomPeriodView *)[gesture view]).index);
    NSLog(@"%ld",self.index);
    if (self.selected) {
        self.selected                  = NO;
        self.imageView.backgroundColor = SelectedColor;
        self.label.backgroundColor     = SelectedColor;
    }else{
        self.selected                  = YES;
        self.imageView.backgroundColor = MAIN_COLOR;
        self.label.backgroundColor     = MAIN_COLOR;
    }
    
}


@end
