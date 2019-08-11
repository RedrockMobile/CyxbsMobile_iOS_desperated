//
//  ViewController.m
//  FYHSegmentedController
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHSegmentesController.h"

#define FYHColor(r,g,b) [UIColor colorWithRed:(r) / 256.0 green:(g) / 256.0 blue:(b) / 256.0 alpha:1]
#define FYHRandomColor FYHColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define SEGMENTBAR_H 49
#define CELL_H 53

@interface FYHSegmentesController ()

@end

@implementation FYHSegmentesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.controllersScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.controllersScrollView.pagingEnabled = YES;
    self.controllersScrollView.showsVerticalScrollIndicator = NO;
    self.controllersScrollView.showsHorizontalScrollIndicator = NO;
    self.controllersScrollView.delegate = self;
    
    [self.view addSubview:self.controllersScrollView];
    
    [self addSubControllers];
    
    [self buildSegmentBar];
    [self buildSubViews];}

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers {
    self = [self init];
    
    self.selectedIndex = 0;
    self.controllers = controllers;
    
    return self;
}


- (void)addSubControllers {
    UIViewController *vc1 = [[UIViewController alloc] init];
    UIViewController *vc2 = [[UIViewController alloc] init];
    UIViewController *vc3 = [[UIViewController alloc] init];

    vc1.view.backgroundColor = FYHRandomColor;
    vc2.view.backgroundColor = FYHRandomColor;
    vc3.view.backgroundColor = FYHRandomColor;
    
    vc1.title = @"vc1";
    vc2.title = @"vc2";
    vc3.title = @"vc3";

    self.controllers = @[vc1, vc2, vc3];
}

- (void)buildSegmentBar {
    // segmentBar
    self.segmentBar = [[UIScrollView alloc] init];
    self.segmentBar.showsVerticalScrollIndicator = NO;
    self.segmentBar.showsHorizontalScrollIndicator = NO;
    self.segmentBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    
    self.segmentBar.frame = CGRectMake(0, 0, MAIN_SCREEN_W, SEGMENTBAR_H);
    
    if (self.controllers.count <= 5) {
        self.segmentBar.contentSize = CGSizeMake(MAIN_SCREEN_W, 0);
    } else {
        self.segmentBar.contentSize = CGSizeMake(MAIN_SCREEN_W / 5 * self.controllers.count, 0);
    }
    
    [self.view addSubview:self.segmentBar];
    
    // 按钮
    CGFloat buttonWidth = self.segmentBar.contentSize.width / self.controllers.count;
    NSMutableArray *tempSegmentButtons = [NSMutableArray array];
    for (int i = 0; i < self.controllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, 45);
        [button setTitle:self.controllers[i].title forState:UIControlStateNormal];
        [button.titleLabel sizeToFit];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag = i;
        
        [tempSegmentButtons addObject:button];
        
        [button addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.segmentBar addSubview:button];
    }
    self.segmentButtons = tempSegmentButtons;
    
    // 滑块
    UIButton *firstButton = self.segmentBar.subviews.firstObject;
    self.slider = [[UIImageView alloc] init];
    self.slider.frame = CGRectMake(0, 0, firstButton.titleLabel.frame.size.width, 4);
    self.slider.center = CGPointMake(buttonWidth * 0.5, 47);
    self.slider.backgroundColor = [UIColor blueColor];
    [self.segmentBar addSubview:self.slider];
}

- (void)segmentButtonClick:(UIButton *)button {
    self.selectedIndex = button.tag;
    [UIView animateWithDuration:0.25 animations:^{
        self.controllersScrollView.contentOffset = CGPointMake(MAIN_SCREEN_W * self.selectedIndex, self.controllersScrollView.contentOffset.y);
        [self moveSlider];
    }];
}

- (void)buildSubViews {
    for (int i = 0; i < self.controllers.count; i++) {
        [self addChildViewController:self.controllers[i]];
        self.controllers[i].view.frame = CGRectMake(i * MAIN_SCREEN_W, 100, MAIN_SCREEN_W, self.controllersScrollView.frame.size.height - TOTAL_TOP_HEIGHT);
        [self.controllersScrollView addSubview:self.controllers[i].view];
    }
    self.controllersScrollView.contentSize = CGSizeMake(MAIN_SCREEN_W * self.controllers.count, 0);
}

- (void)moveSlider {
    UIButton *firstButton = self.segmentBar.subviews.firstObject;
    CGFloat buttonWidth = firstButton.frame.size.width;
    CGFloat sliderXToView = self.slider.frame.origin.x - self.segmentBar.contentOffset.x;
    [UIView animateWithDuration:0.25 animations:^{
        self.slider.frame = CGRectMake(0, 0, firstButton.titleLabel.frame.size.width, 4);
        self.slider.center = CGPointMake(buttonWidth * 0.5 + self.controllersScrollView.contentOffset.x / MAIN_SCREEN_W * buttonWidth, 47);
        if (sliderXToView + self.slider.frame.size.width - 20 > MAIN_SCREEN_W) {
            [UIView animateWithDuration:0.25 animations:^{
                self.segmentBar.contentOffset = CGPointMake(self.segmentBar.contentOffset.x + buttonWidth, self.segmentBar.contentOffset.y);
            }];
        } else if (sliderXToView + 20 < 0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.segmentBar.contentOffset = CGPointMake(self.segmentBar.contentOffset.x - buttonWidth, self.segmentBar.contentOffset.y);
            }];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self moveSlider];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.selectedIndex = self.controllersScrollView.contentOffset.x / MAIN_SCREEN_W;
}

@end
