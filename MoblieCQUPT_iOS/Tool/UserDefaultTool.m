//
//  UserDefaultTool.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "UserDefaultTool.h"

@implementation UserDefaultTool
+(void)saveValue:(id) value forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+(id)valueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+(BOOL)boolValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+ (void)saveParameter:(NSDictionary *)paramterDic{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramterDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([key isEqualToString:@"id"]){
            key = @"user_id";
        }
        [userDefaults setObject:obj forKey:key];
    }];
    [lock unlock];
}

+(void)print{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    NSLog(@"%@",dic);
}

+(NSString *)getStuNum{
    return [self valueWithKey:@"stuNum"];
}

+(void)saveStuNum:(NSString *)stuNum{
    [self saveValue:stuNum forKey:@"stuNum"];
}

+(NSString *)getIdNum{
    return [self valueWithKey:@"idNum"];
}

+(void)removeALLData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults dictionaryRepresentation];
    for (id key in dic) {
        [defaults removeObjectForKey:key];
    }
}

@end
