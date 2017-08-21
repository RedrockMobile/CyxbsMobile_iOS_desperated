//
//  SegmentView.h
//  GGSgmentView
//
//  Created by GQuEen on 16/8/7.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegementViewScrollerViewDelegate <NSObject>

@required

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index;

@end

@interface SegementView : UIView
@property (assign, nonatomic) NSInteger currentIndex;

@property (weak,nonatomic) id<SegementViewScrollerViewDelegate> eventDelegate;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)subviewControllers;


@end
