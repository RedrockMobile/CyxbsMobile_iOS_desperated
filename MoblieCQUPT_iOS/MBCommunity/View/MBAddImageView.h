//
//  MBAddImageView.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/5/1.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBAddImageView;

@protocol MBAddImageViewDelegate <NSObject>

@optional

- (void)clickDelete:(MBAddImageView *)sender;

@end

@interface MBAddImageView : UIImageView

@property (weak, nonatomic) id<MBAddImageViewDelegate> delegate;

@end
