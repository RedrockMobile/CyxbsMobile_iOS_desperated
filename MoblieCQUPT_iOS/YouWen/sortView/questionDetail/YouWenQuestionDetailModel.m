//
//  YouWenDetailModel.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/9.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenQuestionDetailModel.h"

@implementation YouWenQuestionDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        [self setDataWithDic:dic];
    }
    
    return self;
}

- (void)setDataWithDic:(NSDictionary *)dic {
    self.title = dic[@"title"];
    self.descriptionStr = dic[@"description"];
    self.disappearTime = dic[@"disappear_at"];
    self.reward = dic[@"reward"];
    self.nickName = dic[@"questioner_nickname"];
    self.avatar = dic[@"questioner_photo_thumbnail_src"];
    self.gender = dic[@"questioner_gender"];
    self.isSelf = dic[@"is_self"];
    for (NSString *url in dic[@"photo_urls"]) {
        [self.picArr addObject:url];
    }
}

@end
