//
//  LoginEntry.h
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/5.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LoginEntry : NSObject
//+ (void)loginWithStuNum:(NSString *)stuNum
//                  idNum:(NSString *)idNum
//        dictionaryParam:(NSDictionary *)paramDictionary;

//+ (void)loginoutWithParamArrayString:(NSArray *) paramArray;

+ (void)loginWithParamter:(NSDictionary *)paramter;

+ (void)loginOut;
@end
