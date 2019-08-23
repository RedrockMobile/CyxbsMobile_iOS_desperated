//
//  SchoolPicScrollView.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/23.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SchoolPicScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPictures:(NSArray<NSURL *> *)imageURLArray;

@end

NS_ASSUME_NONNULL_END
