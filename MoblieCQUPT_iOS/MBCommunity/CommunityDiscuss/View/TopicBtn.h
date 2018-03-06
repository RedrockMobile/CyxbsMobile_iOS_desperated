//
//  TopicBtn.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/21.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface TopicBtn : UIButton
- (instancetype)initWithFrame:(CGRect)frame andTopic:(TopicModel *)topic;
@end
