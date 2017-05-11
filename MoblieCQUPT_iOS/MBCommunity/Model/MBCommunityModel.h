//
//  MBCommunityModel.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MBCommunityModelType) {
    MBCommunityModelTypeHot,
    MBCommunityModelTypeListArticle,
    MBCommunityModelTypeListNews
};


@interface MBCommunityModel : NSObject

@property (copy, nonatomic) NSNumber *type_id;

@property (copy, nonatomic) NSNumber *article_id;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *detailContent;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSNumber *like_num;
@property (copy, nonatomic) NSNumber *remark_num;
@property BOOL is_my_like;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *user_photo_src;
@property (copy, nonatomic) NSString * user_thumbnail_src;
@property (copy, nonatomic) NSString * article_photo_src;
@property (copy, nonatomic) NSString * article_thumbnail_src;
@property (assign, nonatomic) MBCommunityModelType modelType;
@property NSMutableArray * articlePictureArray;
@property NSMutableArray * articleThumbnailPictureArray;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
