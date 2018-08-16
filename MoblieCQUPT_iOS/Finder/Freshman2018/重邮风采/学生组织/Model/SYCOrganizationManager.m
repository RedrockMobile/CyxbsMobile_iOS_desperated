//
//  SYCOrganizationManager.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationManager.h"

@implementation SYCOrganizationManager

+ (instancetype)sharedInstance{
    static SYCOrganizationManager *sharedInstance = nil;
    //如果已经创建过就不创建
    if (!sharedInstance) {
        sharedInstance = [[self alloc] initPrivate];
    }
    return sharedInstance;
}

//如果调用init方法，就应该提示使用sharedStore方法
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[SYCDataStore sharedStore]" userInfo:nil];
    return nil;
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
    
    [manager GET:@"http://118.24.175.82/search/school/getname" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.organizationData = [NSDictionary dictionaryWithDictionary:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@---",error);
    }];
}
@end
