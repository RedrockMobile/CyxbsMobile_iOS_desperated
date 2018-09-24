//
//  SchoolCarModel.h
//  SchoolCarDemo
//
//  Created by 周杰 on 2018/3/11.
//  Copyright © 2018年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolCarModel : NSObject
@property (assign, nonatomic) double lonitude;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double speed;
@property (assign, nonatomic) double carID;
@property (nonatomic, copy)NSString *timeString;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
