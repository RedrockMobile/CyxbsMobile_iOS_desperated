//
//  autoScrollView.h
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol autoScrollViewDelegate;



@interface autoScrollView : UIView
{
    __unsafe_unretained id <autoScrollViewDelegate> _delegate;
}
@property (nonatomic, assign) id <autoScrollViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;


@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;


@end


@protocol autoScrollViewDelegate <NSObject>
@optional
- (void)didClickPage:(autoScrollView *)view atIndex:(NSInteger)index;

@end
