//
//  LostItem.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/18.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LostItem : NSObject
@property (nonatomic, strong) NSNumber *pro_id;
@property (nonatomic, copy) NSString *pro_name;
@property (nonatomic, copy) NSString *connect_name;
@property (nonatomic, copy) NSString *connect_wx;
@property (nonatomic, copy) NSString *wx_avatar;
@property (nonatomic, copy) NSString *pro_description;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *L_or_F_time;
@property (nonatomic, copy) NSString *L_or_F_place;
@property (nonatomic, copy) NSString *connect_phone;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
