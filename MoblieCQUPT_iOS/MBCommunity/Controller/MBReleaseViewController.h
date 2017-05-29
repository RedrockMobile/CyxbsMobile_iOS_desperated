//
//  MBReleaseViewController.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBInputView.h"
#import "TopicModel.h"

@interface MBReleaseViewController : UIViewController
- (instancetype)initWithTopic:(TopicModel *)topic;
@property (nonatomic, strong) void(^updateBlock)();
@end
