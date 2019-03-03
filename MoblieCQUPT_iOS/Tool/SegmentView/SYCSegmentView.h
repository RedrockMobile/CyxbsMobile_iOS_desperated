//
//  SYCSegmentView.h
//  SYCSegmentView
//
//  Created by 施昱丞 on 2018/8/28.
//  Copyright © 2018年 Shi Yucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//SegmentView类型，SYCSegmentViewTypeNormal为普通，SYCSegmentViewTypeButton为按钮形
typedef NS_ENUM(NSUInteger, SYCSegmentViewType){
    SYCSegmentViewTypeNormal = 0,
    SYCSegmentViewTypeButton = 1,
};

@protocol SYCSegmentViewDelegate <NSObject>

//滑动触发的动作
@required
- (void)scrollEventWithIndex:(NSInteger) index;

@end

@interface SYCSegmentView : UIView

@property (nonatomic, weak) id<SYCSegmentViewDelegate> eventDelegate;
@property (nonatomic) CGFloat titleHeight;  //标签栏高度
@property (nonatomic, strong) UIColor *selectedTitleColor;  //标签选中时的字体颜色
@property (nonatomic, strong) UIColor *titleColor;  //标签字体颜色
@property (nonatomic, strong) UIFont *titleFont;    //标签字体属性
@property (nonatomic, strong) UIColor *titleBackgroundColor;    //标签背景颜色
@property (nonatomic) SYCSegmentViewType segmentType;   //SegmentView类型

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray <UIViewController *> *)controllers type:(SYCSegmentViewType)type;
- (void)setTitleColor:(UIColor *)titleColor;
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor;
- (void)setFont:(UIFont *)font;

@end


