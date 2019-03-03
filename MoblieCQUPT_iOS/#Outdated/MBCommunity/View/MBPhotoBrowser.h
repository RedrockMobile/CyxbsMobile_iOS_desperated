//
//  MBPhotoBrowser.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBBrowserItem.h"


@interface MBPhotoBrowser : UIView

@property (assign, nonatomic) BOOL isLoadHigthImage;

@property (nonatomic, weak) UIView *sourceContainerView;

@property (strong, nonatomic) NSArray *sourceImageArray;

@property (strong, nonatomic) NSArray *sourceThumbnailPictureArray;

@property (assign, nonatomic) NSInteger currentImageItem;

@property (strong, nonatomic) NSArray *imageViewOriginArray;



- (void)show;

- (instancetype)initWithSourceContainerView:(UIView *)sourceContainerView
                           currentImageItem:(NSInteger)currentImageItem
                           sourceImageArray:(NSArray *)sourceImageArray
                sourceThumbnailPictureArray:(NSArray *)sourceThumbnailPictureArray
                       imageViewOriginArray:(NSArray *)imageViewOriginArray ;


@end
