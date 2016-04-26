//
//  MBSegmentedView.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/31.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSegmentBtnBlock) (UIButton *sender);
typedef void(^ScrollViewBlock) (NSInteger index);

@interface MBSegmentedView : UIView

@property (strong, nonatomic) UIButton *segmentBtn;
@property (strong, nonatomic) UIView *underLine;
@property (strong, nonatomic) UIScrollView *backScrollView;

@property (strong, nonatomic) UIButton *currentSelectBtn;
@property (assign, nonatomic) NSInteger currentBtnIndex;

@property (strong, nonatomic) NSMutableArray *segmentBtnArray;

@property (copy, nonatomic) ClickSegmentBtnBlock clickSegmentBtnBlock;
@property (copy, nonatomic) ScrollViewBlock scrollViewBlock;

//@property (weak, nonatomic) id delegate;

- (instancetype)initWithFrame:(CGRect)frame withSegments:(NSArray *)segments;
@end

