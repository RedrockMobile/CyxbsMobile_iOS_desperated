//
//  SplashModel.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/10.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "SplashModel.h"

@implementation SplashModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.target_url = dic[@"target_url"];
        self.photo_src = dic[@"photo_src"];
        self.start = dic[@"start"];
        self.idNum = dic[@"id"];
        self.column = dic[@"column"];
    }
    return self;
}
@end
