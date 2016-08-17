//
//  MBNewsModel.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/8/17.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MBNewsShowType) {
    MBNewsModelNormal,
    MBNewsModelDetail

};

@interface MBNewsModel : NSObject

//类型id
@property (copy, nonatomic) NSString *type_id;
//昵称
@property (copy, nonatomic) NSString *IDLabel;
//文章内容ID
@property (copy, nonatomic) NSString *contentID;
//标题
@property (copy, nonatomic) NSString *title;
//内容
@property (copy, nonatomic) NSString *content;
//时间
@property (copy, nonatomic) NSString *date;
//点赞数
@property (copy, nonatomic) NSString *numOfLike;
//评论数
@property (copy, nonatomic) NSString *numOfRemark;

//是否我点赞
@property (copy, nonatomic) NSString *isMyLike;

@property (assign, nonatomic) MBNewsShowType showType;


- (instancetype)initWithDictionary:(NSDictionary *)dic withMBNewsShowType:(MBNewsShowType)showType;

@end
