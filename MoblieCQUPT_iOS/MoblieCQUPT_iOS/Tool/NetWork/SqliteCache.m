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
static const NSString *dataBaseName = @"ORWCacheSqlite";

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
            NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' TEXT PRIMARY KEY,'%@' BLOG, '%@' INTEGER)", self.dataBaseName,ORWPrimaryKeyCol,ORWDataCol,ORWDeadtimeCol];
            
            BOOL isCreate = [self.db executeUpdate:sqlCreateTable];
            if (!isCreate) {
                NSLog(@"error when creating cache db table");
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
    NSString *documents = [paths lastObject];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",self.dataBaseName,self.dataBaseNameEXT];
    NSString *dataFilePath = [documents stringByAppendingPathComponent:fileName];
    
    return dataFilePath;
}

- (NSString *)dataBaseNameEXT{
    if (!_dataBaseNameEXT) {
        _dataBaseNameEXT = [@"db" copy];
    }
    return _dataBaseNameEXT;
}

- (NSInteger)defaultCacheTime{
    if (!_defaultCacheTime) {
        return 60*60*24;
    }
    return _defaultCacheTime;
}


/** 查询相关 **/
/**
 *  @author Orange-W, 15-09-18 14:09:18
 *
 *  @brief  打印缓存列表
 *  @return 列表字段字典
 */
-(NSDictionary *)selectCacheDataList{
    return [self selectCacheDataWithSql:[NSString stringWithFormat:@"SELECT * FROM '%@'",self.dataBaseName]];
}

/**
 *  @author Orange-W, 15-09-18 14:09:51
 *
 *  @brief  基本查询方法
 *  @param url url主键查找
 *  @return 请求的 data 数据字典
 */
- (NSDictionary *)selectCacheDataWithUrl:(NSString *)url{
    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE '%@'='%@'",self.dataBaseName,ORWPrimaryKeyCol,url];
    return [self selectCacheDataWithSql:selectSql];
}


- (NSDictionary *)selectCacheDataWithSql:(NSString *)selectSql{
    if ([self.db open]) {
        FMResultSet * result = [self.db executeQuery:selectSql];
        [self.db close];
        if([result next]) {
            NSString *requestUrl = [result stringForColumn:[ORWPrimaryKeyCol copy]];
            NSData *requestData = [result dataForColumn:[ORWDataCol copy]];

            NSInteger deadtime = [result intForColumn:[ORWDeadtimeCol copy]];
            NSDictionary *returnData = @{@"request_url":requestUrl,
                                         @"request_data":requestData,
                                         @"deadtime":[NSNumber numberWithInteger:deadtime]};
            return returnData;
        }
    }
    return nil;
}


/** 插入/跟新相关 **/
/**
 *  @author Orange-W, 15-09-18 14:09:43
 *
 *  @brief  基本缓存方法,使用默认缓存时间(6小时)
 *  @param dictionaryData 缓存的字典
 *  @param urlString      缓存地址,url 主键
 *  @return 成功/失败
 */
- (BOOL)saveDataWithDictionary:(NSDictionary *) dictionaryData
                           url:(NSString *) urlString{
    return [self saveDataWithDictionary:dictionaryData url:urlString cacheTime:self.defaultCacheTime];
}

/**
 *  @author Orange-W, 15-09-18 14:09:08
 *
 *  @brief  基本数据存储
 *  @param dictionaryData  数据字典
 *  @param urlString      网址
 *  @param second         缓存时间(秒)
 *  @return 成功/失败
 */
- (BOOL)saveDataWithDictionary:(NSDictionary *) dictionaryData
                           url:(NSString *) urlString
                     cacheTime:(NSInteger) second{
    second = second>0?:60*60*24*365;
    second += [[self getNowDateComponents] second];
    
    
#warning (二进制格式转换要改)
    NSString *updateSql = [NSString
                           stringWithFormat:@"REPLACE INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%ld')",
                           self.dataBaseName,
                           ORWPrimaryKeyCol,
                           ORWDataCol,
                           ORWDeadtimeCol,
                           urlString,dictionaryData,second];
    if ([self.db open]) {
        
        BOOL isUpdate = [self.db executeUpdate:updateSql];
        [self.db close];
        if (!isUpdate) {
            NSLog(@"error when insert cache db data");
        }else{
            return YES;
        }
        
    }
    
    return NO;
}

- (BOOL)updateDataWithSql:(NSString *)updateSql{
    if ([self.db open]) {
        BOOL isUpdate = [self.db executeUpdate:updateSql];
        [self.db close];
        if (!isUpdate) {
            NSLog(@"error when insert cache db data");
        }else{
            return YES;
        }
        
    }
    
    return NO;
}


- (NSDateComponents *) getNowDateComponents{
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    comps = [calendar components:unitFlags fromDate:now];
    return comps;
}

@end
