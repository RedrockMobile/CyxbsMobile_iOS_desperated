//
//  TransparentView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/8.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransparentView : UIView
@property (strong, nonatomic) UIView *whiteView;
@property (assign, nonatomic) BOOL enableBack;
- (instancetype)initTheWhiteViewHeight:(CGFloat)height;
@end
