//
//  LXAskDetailModel.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "LXAskDetailModel.h"

@implementation LXAskDetailModel

- (instancetype) initWithDic:(NSDictionary *)dic {
    self.quesStr = dic[@"title"];
    self.ansStr = dic[@"answer_content"];
    self.solveTimeStr = dic[@"solve_time"];
    self.disapperTimeStr = dic[@"disappear_at"];
    self.quesID = dic[@"id"];
    
    return self;
}

@end
