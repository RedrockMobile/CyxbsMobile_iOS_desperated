//
//  dailyAttendanceModel.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol getSoreDelegate <NSObject>
- (void)getSore:(NSString *)sore;
@end
@interface dailyAttendanceModel : NSObject
@property (nonatomic, weak) id<getSoreDelegate> delegate;
- (void)requestNewScore;
@end
