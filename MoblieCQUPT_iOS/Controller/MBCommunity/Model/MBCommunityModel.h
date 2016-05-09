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

@property (copy, nonatomic) NSString *typeID;

@property (copy, nonatomic) NSString *stuNum;

@property (copy, nonatomic) NSString *headImageView;
@property (copy, nonatomic) NSString *IDLabel;
@property (copy, nonatomic) NSString *timeLabel;
@property (copy, nonatomic) NSString *contentLabel;

@property (copy, nonatomic) NSString *articleID;

@property (strong, nonatomic) NSMutableArray *pictureArray;//高质量图片
@property (strong, nonatomic) NSMutableArray *thumbnailPictureArray;//压缩图片

@property (copy, nonatomic) NSString *numOfSupport;
@property (copy, nonatomic) NSString *numOfComment;

@property (copy, nonatomic) NSString *isMyLike;//我是否点赞


- (instancetype)initWithDictionary:(NSDictionary *)dic withMBCommunityModelType:(MBCommunityModelType)modelType;

@end
