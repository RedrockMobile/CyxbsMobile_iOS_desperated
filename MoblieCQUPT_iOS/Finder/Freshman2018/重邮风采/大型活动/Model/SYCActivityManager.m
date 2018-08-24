//
//  SYCActivityManager.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCActivityManager.h"
#import "SYCActivityModel.h"

@implementation SYCActivityManager

static SYCActivityManager *sharedInstance = nil;

+ (instancetype)sharedInstance{

    //如果已经创建过就不创建
    if (!sharedInstance) {
        NSMutableArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"activityData.archiver"]];
        if (data != nil) {
            sharedInstance = [[SYCActivityManager alloc] init];
            sharedInstance.activityData = data;
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
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    self.error = NO;
    
    [manager GET:@"http://wx.yyeke.com/welcome2018/data/get/byindex" parameters:@{@"index":@"大型活动", @"pagenum":@"1", @"pagesize":@"5"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.activityData = [NSMutableArray array];
        for (NSDictionary *obj in [responseObject objectForKey:@"array"]) {
            [self.activityData addObject:[[SYCActivityModel alloc] initWithName:[obj objectForKey:@"name"] imageURLs:[obj objectForKey:@"picture"] detail:[obj objectForKey:@"content"]]];
        }
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@---",error);
        self.error = YES;
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    [NSKeyedArchiver archiveRootObject:self.activityData toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"activityData.archiver"]];
}

@end
