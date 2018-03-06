//
//  SegmentView.h
//  GGSgmentView
//
//  Created by GQuEen on 16/8/7.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentViewDelegate <NSObject>
@required
- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index;
@end

@interface SegmentView : UIView

@property (nonatomic, weak) id<SegmentViewDelegate> eventDelegate;
@property (nonatomic, assign) CGFloat titleViewHeight;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign, readonly) NSInteger currentIndex;
@property (nonatomic, strong) UIFont *font;
- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray <UIViewController *> *)controllers;

@end
