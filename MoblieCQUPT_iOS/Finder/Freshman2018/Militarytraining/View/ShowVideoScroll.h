//
//  ShowVideoScroll.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowVideoScroll : UIView
/**
 初始化
 
 @param frame 设置View大小
 @param distance 设置Scroll距离View两侧距离
 @param gap 设置Scroll内部 图片间距
 @return 初始化返回值
 */
- (instancetype)initWithFrame:(CGRect)frame withDistanceForScroll:(float)distance withGap:(float)gap;

/** 滚动视图数据 */

-(void)addScrollViewWithArray:(NSArray *)dataArray;
@end
