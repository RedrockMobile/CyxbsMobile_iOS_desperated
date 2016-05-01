//
//  MBAddPhotoContainerView.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/30.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickAddBlock)(UIButton *sender);
//发布界面的图片容器

@interface MBAddPhotoContainerView : UIView

@property (strong, nonatomic) NSArray *sourcePicArray;

@property (copy, nonatomic) ClickAddBlock clickAddBlock;


@end
