//
//  SYCCollageDataManager.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCCollageDataManager.h"
#include "SYCCollageModel.h"
#import "HttpClient.h"

@implementation SYCCollageDataManager

static SYCCollageDataManager *sharedInstance = nil;

+ (instancetype)sharedInstance{

    //如果已经创建过就不创建
    if (!sharedInstance) {
        if ([NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"nameList.archiver"]] && [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collageData.archiver"]]) {
            sharedInstance = [[self alloc] init];
            sharedInstance.nameList = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"nameList.archiver"]];
            sharedInstance.collageData = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collageData.archiver"]];
        }else{
            sharedInstance = [[self alloc] initPrivate];
        }
    }
    return sharedInstance;
}

//真正的（私有的）初始化方法
- (instancetype)initPrivate{
    self = [super init];
    if (self) {
        [self getAllData];
    }
    return self;
}

- (void)getAllData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.error = NO;
    [manager GET:@"http://47.106.33.112:8080/welcome2018/search/school/getname" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.nameList = [NSDictionary dictionaryWithDictionary:responseObject];
        [self getCollageData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error = YES;
        NSLog(@"%@---",error);
    }];
}

- (void)getCollageData{
    self.collageData = [[NSMutableDictionary alloc] init];
    for (NSString *name in [self.nameList objectForKey:@"name"]) {
        __block NSDictionary *sexRatio;
        __block NSDictionary *subjects;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        [manager GET:@"http://47.106.33.112:8080/welcome2018/search/school/1" parameters:@{@"name":name} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            sexRatio = [NSDictionary dictionaryWithDictionary:responseObject];
            
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@---",error);
            self.error = YES;
            dispatch_semaphore_signal(semaphore);
            return;
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        [manager GET:@"http://47.106.33.112:8080/welcome2018/search/school/2" parameters:@{@"name":name} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            subjects = [[NSDictionary dictionaryWithDictionary:responseObject] objectForKey:@"array"];
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@---",error);
            self.error = YES;
            dispatch_semaphore_signal(semaphore);
            return;
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        [self.collageData setObject:[[SYCCollageModel alloc] initWithName:name andSexRatio:sexRatio andSubjects:subjects] forKey:name];
    }
    
    [NSKeyedArchiver archiveRootObject:self.nameList toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"nameList.archiver"]];
    [NSKeyedArchiver archiveRootObject:self.collageData toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collageData.archiver"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DataDownloadDone" object:nil];
    
    
}


@end
