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

    if (dic[@"title"]) {
        //问一问
        self.ansStr = dic[@"answer_content"];
        self.askQuesStr = dic[@"title"];
    }
    if (dic[@"content"]) {
        //帮一帮
        self.helpContent = dic[@"content"];
        self.helptitle = dic[@"question_title"];
    }
    
    self.disapperTimeStr = dic[@"disappear_at"];
    self.createdTimeStr = dic[@"created_at"];
    self.updatedTimeStr = dic[@"updated_at"];
    self.quesID = dic[@"id"];
    
    return self;
}

@end
