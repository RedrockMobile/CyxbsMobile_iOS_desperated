//
//  MBCommentModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommentModel.h"

@implementation MBCommentModel


- (instancetype)initWithDictionary:(NSDictionary *)dic {

    if (self = [super init]) {
        self.stuNum = dic[@"stunum"];
        //昵称
        self.nickname = dic[@"nickname"];
        if ([self.nickname isEqualToString:@""]) {
            self.nickname = @"这个人懒到没有填名字";
        }
        //头像
        self.photo_src = dic[@"photo_src"];
        
        self.created_time = dic[@"created_time"];
        self.content = dic[@"content"];
    }
    return self;
}

@end
