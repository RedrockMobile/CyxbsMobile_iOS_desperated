//
//  MyInfoModel.m
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/5/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MyInfoModel.h"
@implementation MyInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.photo_thumbnail_src forKey:@"photo_thumbnail_src"];
    [aCoder encodeObject:self.photo_src forKey:@"photo_src"];
    [aCoder encodeObject:self.qq forKey:@"qq"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.introduction forKey:@"introduction"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.photo_thumbnail_src = [aDecoder decodeObjectForKey:@"photo_thumbnail_src"];
        self.photo_src = [aDecoder decodeObjectForKey:@"photo_src"];
        self.qq = [aDecoder decodeObjectForKey:@"qq"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.nickname = dic[@"nickname"];
        self.gender = dic[@"gender"];
        NSString *str = dic[@"photo_thumbnail_src"];
        NSURL *url = [NSURL URLWithString:[str stringByReplacingOccurrencesOfString:@"http" withString:@"https"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        self.photo_thumbnail_src = image;
        self.photo_src = dic[@"photo_src"];
        self.qq = dic[@"qq"];
        self.phone = dic[@"phone"];
        self.introduction = dic[@"introduction"];
    }
    return self;
}

- (BOOL) saveMyInfo{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *infoFilePath = [path stringByAppendingPathComponent:@"myinfo"];
    return [NSKeyedArchiver archiveRootObject:self toFile:infoFilePath];
}

+ (MyInfoModel *) getMyInfo{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *infoFilePath = [path stringByAppendingPathComponent:@"myinfo"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:infoFilePath]];
}

+ (BOOL)deleteMyInfo{
    NSError *error;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *infoFilePath = [path stringByAppendingPathComponent:@"myinfo"];
    if([NSData dataWithContentsOfFile:infoFilePath]){
        [[NSFileManager defaultManager] removeItemAtPath:infoFilePath error:&error];
        if (error) {
            NSLog(@"%@",error);
            return NO;
        }
    }
    return YES;
}
@end
