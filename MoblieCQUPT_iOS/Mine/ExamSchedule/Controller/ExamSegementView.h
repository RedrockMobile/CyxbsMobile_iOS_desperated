//
//  ExamSegementView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/6.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentViewScrollerViewDelegate <NSObject>

@required

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index;

@end

@interface ExamSegementView : UIView

@property (weak,nonatomic) id<SegmentViewScrollerViewDelegate> eventDelegate;

- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray <UIViewController *> *)controllers;
@end
