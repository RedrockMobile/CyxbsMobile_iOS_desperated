//
//  TopicModel.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/20.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.topic_id = dic[@"topic_id"];
        self.contentDic = dic[@"content"];
        if (self.contentDic != nil) {
            self.content = self.contentDic[@"content"];
        }
        self.keyword = dic[@"keyword"];
        if(self.keyword != nil){
            self.keyword = [NSString stringWithFormat:@"#%@#",self.keyword];
        }
        self.join_num = dic[@"join_num"];
        self.like_num = dic[@"like_num"];
        self.remark_num = dic[@"remark_num"];
        self.article_num = dic[@"article_num"];
        self.user_id = dic[@"user_id"];
        self.nickname = dic[@"nickname"];
        self.user_photo = dic[@"user_photo"];
        self.is_my_join = dic[@"is_my_join"];
        self.img_small_src = dic[@"img"][@"img_small_src"];
        self.img_src = dic[@"img"][@"img_src"];
        if (![self.img_src isEqualToString:@""]) {
            self.imgArray = [self.img_src componentsSeparatedByString:@","].mutableCopy;
        }
        if (![self.img_small_src isEqualToString:@""]) {
            self.thumbnailImgArray = [self.img_small_src componentsSeparatedByString:@","].mutableCopy;
        }
        for(int i = 0;i<self.imgArray.count;i++){
            if (![self.imgArray[i] hasPrefix:PHOTOURL]) {
                self.imgArray[i] = [PHOTOURL stringByAppendingString:self.imgArray[i]];
            }
        }
        for (int i=0; i<self.thumbnailImgArray.count; i++) {
            if (![self.thumbnailImgArray[i] hasPrefix:PHOTOURL]) {
                self.thumbnailImgArray[i] =  [PHOTOURL stringByAppendingString:self.thumbnailImgArray[i]];
            }
        }
    }
    return self;
}
@end
