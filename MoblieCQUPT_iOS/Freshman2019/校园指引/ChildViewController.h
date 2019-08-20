//
//  ChildViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfiniteRollScrollView.h"

NS_ASSUME_NONNULL_BEGIN



@interface ChildViewController : UIViewController<infiniteRollScrollViewDelegate>
@property(nonatomic,strong) UIImageView* backgroundView;//背景框，图片命名为itemBackgroundImage
@property(nonatomic,strong) InfiniteRollScrollView* scrollImage;//滚动的图片
@property(nonatomic, strong)UILabel*titleLabel;//大标题
@property(nonatomic, strong)UILabel*contentLabel;//小标题
@property (nonatomic, strong) NSString *titleStr;
@end


NS_ASSUME_NONNULL_END
