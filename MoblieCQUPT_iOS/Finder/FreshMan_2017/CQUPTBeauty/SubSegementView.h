//
//  SubSegementView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SubSegmentViewScrollerViewDelegate <NSObject>

@required

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index;

@end

@interface SubSegementView : UIView

@property (weak,nonatomic) id<SubSegmentViewScrollerViewDelegate> eventDelegate;

- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray <UIViewController *> *)controllers;
@end
