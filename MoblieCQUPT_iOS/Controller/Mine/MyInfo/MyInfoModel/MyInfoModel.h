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
@property (strong, nonatomic)NSMutableString *nickname;
@property (strong, nonatomic)NSString *gender;
@property (strong, nonatomic)UIImageView *thumbnailAvatar;
@property (strong, nonatomic)UIImageView *avatar;
@property (strong, nonatomic)NSMutableString *qq;
@property (strong, nonatomic)NSMutableString *phone;
@property (strong, nonatomic)NSMutableString *introduction;

@end
