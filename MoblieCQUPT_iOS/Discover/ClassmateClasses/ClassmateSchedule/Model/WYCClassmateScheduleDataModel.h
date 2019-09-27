//
//  WYCClassmateScheduleDataModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/3/8.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#define URL @"https://cyxbsmobile.redrock.team/api/kebiao"

@interface WYCClassmateScheduleDataModel : NSObject

@property (nonatomic, strong) NSMutableArray *weekArray;

- (void)getClassBookArray:(NSString *)stu_Num;
- (void)getClassBookArrayFromNet:(NSString *)stu_Num;


@end
