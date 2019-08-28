//
//  SchoolCarModel.m
//  SchoolCarDemo
//
//  Created by 周杰 on 2018/3/11.
//  Copyright © 2018年 周杰. All rights reserved.
//

#import "SchoolCarModel.h"

@implementation SchoolCarModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.latitude = [dic[@"lat"]doubleValue];
        self.lonitude = [dic[@"lon"]doubleValue];
        self.speed = [dic[@"speed"]doubleValue];
        self.carID = [dic[@"id"]doubleValue];
        self.timeString = dic[@"time"];
    }
    return self;
}

@end
