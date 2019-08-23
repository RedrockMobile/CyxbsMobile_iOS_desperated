//
//  LQQZhiLuChongYouViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfiniteRollScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LQQXiaoYuanZhiYinViewController : UIViewController<infiniteRollScrollViewDelegate>
//@property(nonatomic,strong) InfiniteRollScrollView* scrollImage;//滚动的图片
@property(nonatomic, strong)NSString*choosedCollege;//男女比例中用户选择的学院

@end

NS_ASSUME_NONNULL_END
