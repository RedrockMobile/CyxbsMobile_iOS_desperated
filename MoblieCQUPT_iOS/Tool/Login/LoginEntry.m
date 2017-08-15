//
//  LoginEntry.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/5.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "LoginEntry.h"
#import "UserDefaultTool.h"
@implementation LoginEntry
+ (void)loginWithParamter:(NSDictionary *)parameter{
    [UserDefaultTool saveParameter:parameter];
}

//+ (void)loginWithStuNum:(NSString *)stuNum
//                  idNum:(NSString *)idNum
//        dictionaryParam:(NSDictionary *)paramDictionary{
//    [UserDefaultTool saveValue:stuNum forKey:@"stuNum"];
//    [UserDefaultTool saveValue:idNum forKey:@"idNum"];
//    [UserDefaultTool saveParameter:paramDictionary];
//}

//+ (void)loginoutWithParamArrayString:(NSArray *) paramArray{
//    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults removeObjectForKey:@"stuNum"];
//    [userDefaults removeObjectForKey:@"idNum"];
//    NSLock *lock = [[NSLock alloc] init];
//    [lock lock];
//    [paramArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [userDefaults removeObjectForKey:obj];
//    }];
//    [lock unlock];
//}

+ (void)loginOut{
    [MobClick profileSignOff];
    [UserDefaultTool removeALLData];
}
@end
