//
//  AnswerCommentModel.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/5.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "AnswerCommentModel.h"

@implementation AnswerCommentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.nickname = dic[@"nickname"];
        self.date = dic[@"created_at"];
        self.gender = dic[@"gender"];
        self.avatarUrlStr = dic[@"photo_thumbnail_src"];
        self.content = dic[@"content"];
    }
    
    return self;
}
@end
