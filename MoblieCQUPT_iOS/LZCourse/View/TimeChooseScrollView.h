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
@property (nonatomic, strong) NSMutableArray<TickButton *> *btnArray;
@property (nonatomic, assign) BOOL showWeekScrollView;
@end
