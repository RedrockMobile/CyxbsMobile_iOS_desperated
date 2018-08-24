//
//  SYCSegmentView.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/23.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYCSegmentViewType){
    SYCSegmentViewTypeNormal = 0,
    SYCSegmentViewTypeButton = 1,
};

@protocol SYCSegmentViewDelegate <NSObject>

@required
- (void)scrollEventWithIndex:(NSInteger) index;

@end

@interface SYCSegmentView : UIView

@property (nonatomic, weak) id<SYCSegmentViewDelegate> eventDelegate;
@property (nonatomic) CGFloat titleHeight;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, readonly) NSInteger currentIndex;
@property (nonatomic) SYCSegmentViewType segmentType;

- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray <UIViewController *> *)controllers andType:(SYCSegmentViewType)type;

@end


