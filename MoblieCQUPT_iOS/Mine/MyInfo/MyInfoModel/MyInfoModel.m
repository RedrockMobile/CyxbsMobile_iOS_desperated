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
//        self.photo_thumbnail_src = dic[@"photo_thumbnail_src"];
//        self.photo_thumbnail_src = [UIImage imageNamed:dic[@"photo_thumbnail_src"]];
        self.photo_thumbnail_src = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"photo_src"]]]];
        self.photo_src = dic[@"photo_src"];
        self.qq = dic[@"qq"];
        self.phone = dic[@"phone"];
        self.introduction = dic[@"introduction"];
    }
    return self;
}

@end
