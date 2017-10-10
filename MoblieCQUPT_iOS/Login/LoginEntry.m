//
//  LoginEntry.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/5.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "LoginEntry.h"
#import "MyInfoModel.h"
@implementation LoginEntry
+ (void)loginWithParamter:(NSDictionary *)parameter{
    [UserDefaultTool saveParameter:parameter];
}

+ (void)loginOut{
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    NSString *failurePath = [path stringByAppendingPathComponent:@"failure.plist"];
    NSError *error;
    if ([manager removeItemAtPath:remindPath error:&error]) {
        NSLog(@"%@",error);
    }
    if ([manager removeItemAtPath:failurePath error:&error]) {
        NSLog(@"%@",error);
    }
    [MobClick profileSignOff];
    [MyInfoModel deleteMyInfo];
    [UserDefaultTool removeALLData];
}
@end
