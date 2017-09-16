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

+ (void)loginOut{
    [MobClick profileSignOff];
    [UserDefaultTool removeALLData];
}
@end
