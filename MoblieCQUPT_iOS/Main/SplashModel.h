//
//  SplashModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/10.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SplashModel : NSObject
@property (nonatomic, copy) NSString *target_url;
@property (nonatomic, copy) NSString *photo_src;
@property (nonatomic, copy) NSString *start;
@property (nonatomic, copy) NSString *column;
@property (nonatomic, strong) NSNumber *idNum;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
