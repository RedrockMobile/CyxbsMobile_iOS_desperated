//
//  StatisticsTable.h
//  SegmentView
//
//  Created by xiaogou134 on 2017/8/5.
//  Copyright © 2017年 xiaogou134. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsTable : UIView
//初始化方法，每次加载前必用
- (instancetype)initWithFrame:(CGRect)frame With:(NSArray<UIColor *> *) color;
//动画方法
- (void)drawLinesWithDetail:(NSArray<NSDictionary *> *) context With:(NSArray<UIColor *> *) color;
@end
