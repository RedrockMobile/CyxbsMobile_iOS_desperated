//
//  SplashModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/10.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SplashModel : NSObject
@property NSString *target_url;
@property NSString *photo_src;
@property NSString *start;
@property NSNumber *idNum;
@property NSString *column;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
