  //
//  XBSFindClassroomPeriodView.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/12/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSFindClassroomPeriodView.h"
#import "UIColor+BFPaperColors.h"
#import "XBSFindClassroomModel.h"
#import "XBSFindClassroomViewController.h"
#define ImageNameGroup @[@"8oClock", @"10oClock", @"2oClock", @"4oClock", @"7oClock", @"9oClock"]
#define SelectedColor [UIColor paperColorBlue500]
@interface XBSFindClassroomPeriodView ()
@property (nonatomic, strong) XBSFindClassroomViewController *delegate;
@end

@implementation XBSFindClassroomPeriodView

- (instancetype)initWithIndex:(NSInteger)index Delegate:(UIViewController *)delegate{
    self          = [self init];
    self.frame    = CGRectMake(ScreenWidth / 6 * index, 108, ScreenWidth / 6, ScreenWidth / 6 + 25);
    self.index    = index;
    self.selected = NO;
    self.delegate = (XBSFindClassroomViewController *)delegate;
    self.image                     = [[UIImage imageNamed:ImageNameGroup[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView                 = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.backgroundColor = MAIN_COLOR;
    self.imageView.tintColor       = [UIColor whiteColor];
    self.imageView.frame           = CGRectMake(0, 0, ScreenWidth / 6 + 1, ScreenWidth / 6);
    
    self.label                     = [[UILabel alloc]init];
    self.label.backgroundColor     = MAIN_COLOR;
    self.label.textAlignment       = NSTextAlignmentCenter;
    self.label.text                = [NSString stringWithFormat:@"%d~%d",(int)(index * 2 + 1), (int)(index * 2 + 2)];
    self.label.textColor           = [UIColor whiteColor];
    self.label.frame               = CGRectMake(0, ScreenWidth / 6, ScreenWidth / 6 + 1, 25);
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:self.tap];
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)sender  {
    if (!self.delegate.buildingPickerView.hidden) {
        [self.delegate selectCancelled];
        return;
    }
    if (self.selected) {
        self.selected                  = NO;
        self.imageView.backgroundColor = MAIN_COLOR;
        self.label.backgroundColor     = MAIN_COLOR;
    }else{
        self.selected                  = YES;
        self.imageView.backgroundColor = SelectedColor;
        self.label.backgroundColor     = SelectedColor;
    }
    [self.delegate.model refreshEmptyClassroomTableData];
}


@end
