//
//  LoginEntry.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/5.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "LoginEntry.h"

@implementation LoginEntry
+ (BOOL)loginWithId:(NSString *)stuentId
          passworld:(NSString *)passworld
withDictionaryParam:(NSDictionary *)paramDictionary{
    
    NSDate *futureTime = [NSDate dateWithTimeIntervalSinceNow:60*60*24*15];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:stuentId forKey:@"stuNum"];
    [userDefaults setObject:passworld forKey:@"idNum"];
    [userDefaults setObject:futureTime forKey:@"time"];
    
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [userDefaults setObject:obj forKey:key];
    }];
    [lock unlock];
    
    if([userDefaults synchronize]){
        return YES;
    }else{
        return NO;
    }
    
}

+ (BOOL)loginoutWithParamArrayString:(NSArray *) paramArray{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"stuNum"];
    [userDefaults removeObjectForKey:@"idNum"];
    [userDefaults removeObjectForKey:@"time"];
    
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [userDefaults removeObjectForKey:obj];
    }];
    [lock unlock];
    
    if([userDefaults synchronize]){
        return YES;
    }else{
        return NO;
    }
}
@end
