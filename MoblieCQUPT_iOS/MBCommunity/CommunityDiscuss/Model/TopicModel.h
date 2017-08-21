//
//  TopicModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/20.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject
@property NSNumber *topic_id;
@property NSDictionary *contentDic;
@property NSString *content;
@property NSString *keyword;
@property NSNumber *join_num;
@property NSNumber *like_num;
@property NSNumber *remark_num;
@property NSNumber *read_num;
@property NSNumber *article_num;
@property NSString *user_id;
@property NSString *nickname;
@property NSString *user_photo;
@property NSString *img_small_src;
@property NSString *img_src;
@property BOOL is_my_join;
@property NSMutableArray *thumbnailImgArray;
@property NSMutableArray *imgArray;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
