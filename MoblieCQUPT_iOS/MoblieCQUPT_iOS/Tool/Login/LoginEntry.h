//
//  LoginEntry.h
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/5.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginEntry : NSObject

+ (BOOL)loginWithId:(NSString *)stuentId
          passworld:(NSString *)passworld
withDictionaryParam:(NSDictionary *)paramDictionary;

+ (BOOL)loginoutWithParamArrayString:(NSArray *) paramArray;

+ (BOOL)saveByUserdefaultWithDictionary:(NSDictionary *)paramDictionary;
+ (id)getByUserdefaultWithKey:(NSString *)key;
@end
