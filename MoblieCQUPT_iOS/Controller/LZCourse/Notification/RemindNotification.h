//
//  RemindNotification.h
//  Demo
//
//  Created by hzl on 2016/11/30.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindNotification : NSObject

- (void)addNotifictaion;

- (void)deleteNotificationAndIdentifiers;

- (void)updateNotificationWithIdetifiers:(NSString *)newIdentifier;

@end
