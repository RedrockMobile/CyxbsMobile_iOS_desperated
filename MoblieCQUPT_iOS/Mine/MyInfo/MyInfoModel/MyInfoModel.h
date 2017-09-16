//
//  MyInfoModel.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInfoModel : NSObject<NSCoding>

@property (strong, nonatomic)NSString *stuNum;
@property (strong, nonatomic)NSString *idNum;
@property (strong, nonatomic)NSString *introduction;
//@property (strong, nonatomic)NSString *username;
@property (strong, nonatomic)NSString *nickname;
@property (strong, nonatomic)NSString *gender;
@property (strong, nonatomic)UIImage *photo_thumbnail_src;
//@property (strong, nonatomic)NSString *photo_thumbnail_src;
@property (strong, nonatomic)NSString *photo_src;
@property (strong, nonatomic)NSString *qq;
@property (strong, nonatomic)NSString *phone;
//@property (strong, nonatomic)NSString *updated_time;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
