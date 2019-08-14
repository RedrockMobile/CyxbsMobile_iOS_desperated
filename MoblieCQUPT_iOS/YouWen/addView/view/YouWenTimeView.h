//
//  YouWenTimeView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenNextView.h"

@interface YouWenTimeView : YouWenNextView
@property (copy, nonatomic) NSArray *timeData;
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong) NSMutableArray *pickViewArray;
@end
