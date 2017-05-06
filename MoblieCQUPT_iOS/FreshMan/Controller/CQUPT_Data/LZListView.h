//
//  LZListView.h
//  FreshManFeature
//
//  Created by 李展 on 16/8/14.
//  Copyright © 2016年 李展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZScrollView.h"
@protocol LZListViewClickDelegate <NSObject>
- (void)eventWhenClickListViewBtn:(UIButton *)sender;
@end

@interface LZListView : UIView
@property (weak,nonatomic) id <LZListViewClickDelegate> delegate;
@property LZScorllView *scrollView;
-(instancetype) initWithFrame:(CGRect)frame andStringArray:(NSArray *)array andBtnHeight:(CGFloat)height;

@end
