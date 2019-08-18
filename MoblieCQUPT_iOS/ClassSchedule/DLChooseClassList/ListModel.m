//
//  ListModel.m
//  选课名单
//
//  Created by 丁磊 on 2018/9/19.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.stuName = dic[@"stuName"];
        self.stuNum = dic[@"stuId"];
        self.stuSex = dic[@"stuSex"];
        self.classId = dic[@"classId"];
        self.major = dic[@"major"];
        self.school = dic[@"school"];
        self.year = dic[@"year"];
    }
    return self;
}

+ (instancetype)ListModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

@end
