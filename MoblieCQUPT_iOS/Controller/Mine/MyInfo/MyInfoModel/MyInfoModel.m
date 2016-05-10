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
    [aCoder encodeObject:self.nickname forKey:@"nickName"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.thumbnailAvatar forKey:@"thumbnailAvatar"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.qq forKey:@"qq"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.introduction forKey:@"introduction"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.nickname = [aDecoder decodeObjectForKey:@"nickName"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.thumbnailAvatar = [aDecoder decodeObjectForKey:@"thumbnailAvatar"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.qq = [aDecoder decodeObjectForKey:@"qq"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
    }
    return self;
}

@end
