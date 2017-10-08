//
//  EmptyClassView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/10/5.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyClassView : UIView
@property (assign, nonatomic) NSInteger weeks;
@property (assign, nonatomic) NSInteger weekdays;
@property (assign, nonatomic) NSInteger build;
@property (strong, nonatomic) NSMutableArray *time;
@property (strong, nonatomic) UIButton *handleBtn;
@end

