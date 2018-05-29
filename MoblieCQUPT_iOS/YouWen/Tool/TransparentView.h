//
//  TransparentView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/8.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol getNewView <NSObject>
@optional
- (void)newView:(UIButton *)btn;
@end
@interface TransparentView : UIView
@property (strong, nonatomic) UIImageView *squareBox;
@property (strong, nonatomic) UIView *whiteView;
@property (assign, nonatomic) BOOL enableBack;
@property (nonatomic, weak) id <getNewView> delegate;
- (instancetype)initTheWhiteViewHeight:(CGFloat)height;
- (instancetype)initWithNews:(NSArray *)array;
@end
