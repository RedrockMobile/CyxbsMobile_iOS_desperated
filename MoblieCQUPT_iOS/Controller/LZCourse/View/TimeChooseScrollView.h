//
//  TimeChooseScrollView.h
//  Demo
//
//  Created by 李展 on 2016/12/8.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TickButton.h"

@interface TimeChooseScrollView : UIScrollView
@property NSMutableArray<TickButton *> *btnArray;
@property BOOL showWeekScrollView;
@end
