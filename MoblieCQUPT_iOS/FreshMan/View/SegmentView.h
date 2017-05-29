//
//  SegmentView.h
//  GGSgmentView
//
//  Created by GQuEen on 16/8/7.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentViewScrollerViewDelegate <NSObject>

@required

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index;

@end

@interface SegmentView : UIView

@property (weak,nonatomic) id<SegmentViewScrollerViewDelegate> eventDelegate;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)subviewControllers;


@end
