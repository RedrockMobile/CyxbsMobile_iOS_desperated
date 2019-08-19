//
//  GroupModel.m
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.headerTitle = dict[@"title"];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict2 in dict[@"data"]) {
            Model *model = [Model modelWithDictionary:dict2];
            [tempArray addObject:model];
        }
        self.modelArray = tempArray;
    }
    return self;
}

+ (instancetype)groupWithDictinary:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
