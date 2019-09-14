//
//  SYCPictureDisplay.h
//  SYCPictureDisplay
//
//  Created by 施昱丞 on 2018/9/20.
//  Copyright © 2018年 Shi Yucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZCarouselModel.h"

@protocol SYCPictureDisplayDelegate <NSObject>

- (void)didClicked:(NSInteger)index;

@end

@interface SYCPictureDisplayView : UIView

@property (nonatomic, strong) id<SYCPictureDisplayDelegate> delegate;

- (instancetype)initWithData:(NSArray<LZCarouselModel *> *)dataArray;

- (void)buildUI;

@end
