//
//  SqliteCache.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/2.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "SqliteCache.h"
#import "FMDatabase.h"

@interface SqliteCache()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation SqliteCache
static const NSString *dataBaseName = @"ORWCacheSqlite.db";

static const NSString *ORWPrimaryKeyCol = @"request_url";
static const NSString *ORWDataCol = @"data";
static const NSString *ORWDeadtimeCol = @"deadtime";

+ (NSString *)SqliteCacheDataBaseName {
    SqliteCache *cache = [[SqliteCache alloc]init];
    return [cache dataBaseName];
}

+ (NSString *)SqliteCacheFilePath {
    SqliteCache *cache = [[SqliteCache alloc]init];
    return [cache filePath];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.db = [FMDatabase databaseWithPath:[self filePath]];
        if ([self.db open]) {
            NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT PRIMARY KEY,'%@' BLOG, '%@' INTEGER)", self.dataBaseName,ORWPrimaryKeyCol,ORWDataCol,ORWDeadtimeCol];
            BOOL isCreate = [self.db executeUpdate:sqlCreateTable];
            if (!isCreate) {
                NSLog(@"error when creating db table");
            } else {
                NSLog(@"success to creating db table");
            }
            [self.db close];
        }
    }
    return self;
}

- (NSString *)dataBaseName{
    return [dataBaseName copy];
}

- (NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *dataFilePath = [documents stringByAppendingPathComponent:self.dataBaseName];
    return dataFilePath;
}



-(NSDictionary *)selectDataList{
    return [self selectDataWithSql:[NSString stringWithFormat:@"SELECT * FROM '%@'",self.dataBaseName]];
}

- (NSDictionary *)selectDataWithUrl:(NSString *)url{
    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE '%@'='%@'",self.dataBaseName,ORWPrimaryKeyCol,url];
    return [self selectDataWithSql:selectSql];
}

- (NSDictionary *)selectDataWithSql:(NSString *)selectSql{
    if ([self.db open]) {
        FMResultSet * result = [self.db executeQuery:selectSql];
        if([result next]) {
            NSString *requestUrl = [result stringForColumn:[ORWPrimaryKeyCol copy]];
            NSData *requestData = [result dataForColumn:[ORWDataCol copy]];
            NSInteger deadtime = [result intForColumn:[ORWDeadtimeCol copy]];
            NSDictionary *returnData = @{@"request_url":requestUrl,
                                         @"request_data":requestData,
                                         @"deadtime":[NSNumber numberWithInteger:deadtime]};
            [self.db close];
            return returnData;
        }
        [self.db close];
    }
    return nil;
}


@end
