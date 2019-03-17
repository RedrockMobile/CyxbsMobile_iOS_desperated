//
//  WYCScrollViewBar.h
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/31.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYCWeekChooseBar : UIView
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign, readonly) NSInteger currentIndex;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSInteger subviewCountInView;
@property (nonatomic, assign) NSInteger index;
-(instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array;
-(void)changeIndex:(NSInteger)index;

@end
