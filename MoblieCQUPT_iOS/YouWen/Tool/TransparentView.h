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

@property (nonatomic, weak) id <getNewView> delegate;


/**
 传入白色视图高度的初始化方法

 @param height 视图高度
 @return 初始化方法
 */
- (instancetype)initTheWhiteViewHeight:(CGFloat)height;


/**
 传入话题类型的初始化方法

 @param types 话题类型数组
 @return 初始化方法
 */
- (instancetype)initWithTypes:(NSArray *)types;

- (void)popWhiteView;

- (void)pushWhiteView;

- (void)setUpUI;

@end
