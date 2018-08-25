//
//  SYCActivityManager.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCActivityManager : NSObject

@property (nonatomic, strong)NSMutableArray *activityData;
@property Boolean error;

+ (instancetype)sharedInstance;

@end
