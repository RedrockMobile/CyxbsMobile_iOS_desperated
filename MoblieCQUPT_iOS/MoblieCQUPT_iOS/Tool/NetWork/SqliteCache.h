




//  SqliteCache.h
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/2.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteCache : NSObject

typedef NS_ENUM(NSInteger, ORWCacheOption){
    ORWCacheOptionNone = 1,
};

@property (strong, nonatomic, readonly) NSString *dataBaseName;
@property (strong, nonatomic, readonly) NSString *filePath;

+ (NSString *)SqliteCacheDataBaseName;
+ (NSString *)SqliteCacheFilePath;

- (NSString *)dataBaseName;
- (NSString *)filePath;
- (NSDictionary *)selectDataList;
- (NSDictionary *)selectDataWithUrl:(NSString *)url;

@end
