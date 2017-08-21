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

@property (weak,nonatomic) id<SegmentViewDelegate> eventDelegate;

- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray <UIViewController *> *)controllers;

@end
