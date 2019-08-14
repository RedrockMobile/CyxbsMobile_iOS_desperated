//
//  ViewController.h
//  FYHSegmentedController
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYHSegmentesController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) NSArray<UIViewController *> *controllers;
@property (nonatomic, strong) UIScrollView *segmentBar;
@property (nonatomic, strong) UIScrollView *controllersScrollView;
@property (nonatomic, strong) UIImageView *slider;
@property (nonatomic, copy) NSArray<UIButton *> *segmentButtons;

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers;

- (void)buildSubViews;
- (void)addSubControllers;
- (void)segmentButtonClick:(UIButton *)button;
- (void)moveSlider;

@end

