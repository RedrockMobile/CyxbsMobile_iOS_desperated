//
//  YouWenTopicView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenNextView.h"
//求助类型
@protocol whatTopic <NSObject>
@optional
- (void)topicStyle:(NSString *)style;
@end
@interface YouWenTopicView : YouWenNextView
@property (copy, nonatomic) NSMutableString *style;
@property (weak, nonatomic) id <whatTopic> topicDelegate;
@end
