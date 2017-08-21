//
//  LostItem.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/18.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LostItem : NSObject
@property NSNumber *pro_id;
@property NSString *pro_name;
@property NSString *connect_name;
@property NSString *connect_wx;
@property NSString *wx_avatar;
@property NSString *pro_description;
@property NSString *created_at;
@property CGFloat cellHeight;
@property NSString *L_or_F_time;
@property NSString *L_or_F_place;
@property NSString *connect_phone;
@property UIImage  *image;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
