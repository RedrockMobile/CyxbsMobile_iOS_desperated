//
//  SqliteCache.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/2.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "SqliteCache.h"

@implementation SqliteCache
static const NSString *dataBaseName = @"OW_Cache_Sqlite.db";

+ (NSString *)dataBaseName {
    return [NSString stringWithUTF8String:[dataBaseName UTF8String]];
}

+ (NSString *)dataPath {
    NSString *baseName = [NSString stringWithUTF8String:[dataBaseName UTF8String]];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:baseName ofType:@"db"];
    return dataPath;
}

@end
