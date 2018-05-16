//
//  YouWenAnswerDetailModel.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/20.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenAnswerDetailModel.h"

@implementation YouWenAnswerDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        [self setData:dic];
    }
    
    return self;
}

- (void)setData:(NSDictionary *)dic {
    self.avatarUrl = dic[@"photo_thumbnail_src"];
    self.nickname = dic[@"nickname"];
    self.content = dic[@"content"];
    self.timeStr = dic[@"created_at"];
    self.upvoteNum = dic[@"praise_num"];
    self.commentNum = dic[@"comment_num"];
    self.answer_id = dic[@"id"];
    self.is_adopted = [dic[@"is_adopted"] intValue];
    
    if ([dic[@"photo_url"] count] != 0) {
        self.photoUrlArr = [NSMutableArray array];
        for (NSString *url in dic[@"photo_url"]) {
            [self.photoUrlArr addObject:url];
        }
    }
    
}

@end
