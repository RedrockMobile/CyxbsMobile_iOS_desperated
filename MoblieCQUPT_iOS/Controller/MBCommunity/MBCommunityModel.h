//
//  MBCommunityModel.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBCommunityModel : NSObject

@property (copy, nonatomic) NSString *headImageView;
@property (copy, nonatomic) NSString *IDLabel;
@property (copy, nonatomic) NSString *timeLabel;
@property (copy, nonatomic) NSString *contentLabel;

@property (strong, nonatomic) NSArray *pictureArray;//高质量图片
@property (strong, nonatomic) NSArray *comprssPictureArray;//压缩图片

@property (copy, nonatomic) NSString *numOfSupport;
@property (copy, nonatomic) NSString *numOfComment;

@property (assign, nonatomic) BOOL isMyLike;//我是否点赞


@end
