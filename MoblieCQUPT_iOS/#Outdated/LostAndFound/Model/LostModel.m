//
//  LostModel.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LostModel.h"

@implementation LostModel
- (NSDictionary *)packToParamtersDic{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"stu_num"] = self.stu_num;
    dic[@"idNum"] = self.idNum;
    dic[@"property"] = self.property;
    dic[@"category"] = self.category;
    dic[@"detail"] = self.detail;
    dic[@"pickTime"] = self.pickTime;
    dic[@"place"] = self.place;
    dic[@"phone"] = self.phone;
    dic[@"qq"] = self.qq;
    return dic.copy;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.stu_num = self.idNum = self.property = self.category = self.detail = self.pickTime = self.phone = self.qq = @"";
    }
    return self;
}
@end
