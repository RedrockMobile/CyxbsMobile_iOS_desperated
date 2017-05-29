//
//  DetailBannnerView.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/24.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
@interface DetailBannnerView : UIView
- (instancetype)initWithFrame:(CGRect)frame andTopic:(TopicModel *)topic;
- (void)extend;
@property CGFloat extendHeight;
@end
