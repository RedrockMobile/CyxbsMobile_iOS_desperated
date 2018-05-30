//
//  dailyAttendanceModel.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol dailyAttendanceDelegate <NSObject>
- (void)getSore:(NSString *)sore;
- (void)getSerialDay:(NSString *)day AndCheck:(NSString *)check;
@end
@interface dailyAttendanceModel : NSObject
@property (nonatomic, weak) id<dailyAttendanceDelegate> delegate;
- (void)requestNewScore;
- (void)requestContinueDay;
@end
