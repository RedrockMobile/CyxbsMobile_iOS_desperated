//
//  TopicModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/5/20.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject
@property (nonatomic, strong) NSNumber *topic_id;
@property (nonatomic, copy) NSDictionary *contentDic;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) NSNumber *join_num;
@property (nonatomic, strong) NSNumber *like_num;
@property (nonatomic, strong) NSNumber *remark_num;
@property (nonatomic, strong) NSNumber *read_num;
@property (nonatomic, strong) NSNumber *article_num;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *user_photo;
@property (nonatomic, copy) NSString *img_small_src;
@property (nonatomic, copy) NSString *img_src;
@property (nonatomic, assign) BOOL is_my_join;
@property (nonatomic, strong) NSMutableArray *thumbnailImgArray;
@property (nonatomic, strong) NSMutableArray *imgArray;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
