//
//  LostItem.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/18.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LostItem.h"

@implementation LostItem
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.pro_id = [dic objectForKey:@"pro_id"];
        self.pro_name = [dic objectForKey:@"pro_name"];
        self.connect_name = [dic objectForKey:@"connect_name"];
        self.connect_wx = [dic objectForKey:@"connect_wx"];
        self.wx_avatar = [dic objectForKey:@"wx_avatar"];
        self.pro_description = [dic objectForKey:@"pro_description"];
        self.created_at = [dic objectForKey:@"created_at"];
        self.L_or_F_time = [dic objectForKey:@"L_or_F_time"];
        self.L_or_F_place = [dic objectForKey:@"L_or_F_place"];
        self.connect_phone = [dic objectForKey:@"connect_phone"];
    }
    return self;
}
@end
