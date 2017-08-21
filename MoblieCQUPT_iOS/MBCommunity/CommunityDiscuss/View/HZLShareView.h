//
//  HZLShareView.h
//  MoblieCQUPT_iOS
//
//  Created by hzl on 2017/6/6.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLShareView : UIView

//点击按钮
@property (nonatomic, copy) void(^shareClick)(NSInteger);

- (instancetype)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArray:(NSArray *)imageArray andTopic:(NSString *)topicStr andImage:(UIImage *)bgImage;

@end
