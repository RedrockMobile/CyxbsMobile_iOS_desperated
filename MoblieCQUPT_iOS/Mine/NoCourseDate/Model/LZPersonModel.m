//
//  LZPersonModel.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/22.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZPersonModel.h"
#import "MyInfoModel.h"

@implementation LZPersonModel
- (instancetype)initWithData:(NSDictionary *)data{
    self = [self init];
    if (self) {
        _stuNum = data[@"stunum"];
        _name = data[@"name"];
        _gender = data[@"gender"];
        _classnum = data[@"classnum"];
        _major = data[@"major"];
        _depart = data[@"depart"];
        _grade = data[@"grade"];
    }
    return self;
}

- (instancetype)initWithMyInfo:(MyInfoModel *)myInfo{
    self = [super init];
    if (self) {
        self.stuNum = myInfo.stuNum;
        self.name = myInfo.username;
//        self.gender = myInfo.gender;
//        self.classnum = myInfo.className;
    }
    return self;
}
@end
