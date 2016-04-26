//
//  MBBrowserItem.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/19.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBBrowserItemEventDelegate <NSObject>

- (void)didClickedItemToHide;

@end

@interface MBBrowserItem : UIScrollView


@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) NSString *pic;

@property (assign, nonatomic ,getter=isFirstShow) BOOL firstShow;

@property (weak, nonatomic) id<MBBrowserItemEventDelegate> eventDelegate;


//- (void)loadHdImage:(BOOL)animated;



@end
