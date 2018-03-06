//
//  LZCarouselModel.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/10/9.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZCarouselModel.h"

@implementation LZCarouselModel
- (instancetype)initWithData:(NSDictionary *)data{
    self = [self init];
    if (self) {
        self.picture_url = data[@"picture_url"];
        self.picture_goto_url = data[@"picture_goto_url"];
        self.keyword = data[@"keyword"];
//        self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.picture_url]];
//        self.picture = [UIImage imageWithData:self.imageData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.picture_url = [aDecoder decodeObjectForKey:@"picture_url"];
        self.picture_goto_url = [aDecoder decodeObjectForKey:@"picture_goto_url"];
        self.keyword = [aDecoder decodeObjectForKey:@"keyword"];
        self.imageData = [aDecoder decodeObjectForKey:@"imageData"];
        self.picture = [UIImage imageWithData:self.imageData];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.picture_url forKey:@"picture_url"];
    [aCoder encodeObject:self.picture_goto_url forKey:@"picture_goto_url"];
    [aCoder encodeObject:self.keyword forKey:@"keyword"];
    [aCoder encodeObject:self.imageData forKey:@"imageData"];
}

@end
