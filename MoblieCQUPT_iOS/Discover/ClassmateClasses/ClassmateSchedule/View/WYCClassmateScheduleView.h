//
//  WYCClassmateScheduleView.h
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WYCClassmateScheduleViewDelegate <NSObject>
@required
- (void)showDetail:(NSArray *)array;
@end


@interface WYCClassmateScheduleView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) id<WYCClassmateScheduleViewDelegate> detailDelegate;
-(void)initView:(BOOL)isFirst;
-(void)addBar:(NSArray *)date isFirst:(BOOL)isFirst;
-(void)addBtn:(NSMutableArray *)day;


-(void)changeScrollViewContentSize:(CGSize)contentSize;
@end
