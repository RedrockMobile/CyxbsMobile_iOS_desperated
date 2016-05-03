//
//  MBAddPhotoContainerView.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/30.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

//发布界面的图片容器

@protocol MBAddPhotoContainerViewAddEventDelegate <NSObject>

@optional

- (void)clickPhotoContainerViewAdd;

@end

@interface MBAddPhotoContainerView : UIView

@property (strong, nonatomic) NSArray *sourcePicArray;

@property (weak, nonatomic) id<MBAddPhotoContainerViewAddEventDelegate> eventDelegate;


@end
