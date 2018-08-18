//
//  FoodModel.m
//  迎新
//
//  Created by 陈大炮 on 2018/8/15.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.name = dic[@"name"];
        self.pictureURL = dic[@"picture"];
        self.illstrate = dic[@"content"];
    }
    return self;
}
@end
