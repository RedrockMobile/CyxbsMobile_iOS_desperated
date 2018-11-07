//
//  SYCOrganizationManager.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationManager.h"
#import "SYCOrganizationModel.h"

@implementation SYCOrganizationManager

static SYCOrganizationManager *sharedInstance = nil;

+ (instancetype)sharedInstance{
    //如果已经创建过就不创建
    if (!sharedInstance) {
        sharedInstance = [[self alloc] initPrivate];
    }
    return sharedInstance;
}

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
    
    [manager GET:@"http://wx.yyeke.com/welcome2018/data/get/byindex" parameters:@{@"index":@"学生组织", @"pagenum":@"1", @"pagesize":@"30"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.organizationData = [NSMutableArray array];
        for (NSDictionary *obj in [responseObject objectForKey:@"array"]) {
            [self.organizationData addObject:[[SYCOrganizationModel alloc] initWithName:[obj objectForKey:@"name"] imageURLs:[obj objectForKey:@"picture"] detail:[obj objectForKey:@"content"]]];
        }
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@---",error);
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    [NSKeyedArchiver archiveRootObject:self.organizationData toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"organizationData.archiver"]];
}
@end
