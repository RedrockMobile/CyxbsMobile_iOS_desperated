//
//  LoginEntry.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/5.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "LoginEntry.h"
@implementation LoginEntry
+ (void)loginWithParamter:(NSDictionary *)parameter{
    [UserDefaultTool saveParameter:parameter];
}

+ (void)loginOut{
    [MobClick profileSignOff];
    NSError *error;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *infoFilePath = [path stringByAppendingPathComponent:@"myinfo"];    if([NSData dataWithContentsOfFile:infoFilePath]){
        [[NSFileManager defaultManager] removeItemAtPath:infoFilePath error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
    }
    [UserDefaultTool removeALLData];
}
@end
