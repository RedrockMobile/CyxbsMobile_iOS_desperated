//
//  CategoryChooseView.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TickButton.h"

@interface CategoryChooseView : UIScrollView
@property NSMutableArray<TickButton *> *btnArray;

- (instancetype)initWithFrame:(CGRect)frame;

@end
