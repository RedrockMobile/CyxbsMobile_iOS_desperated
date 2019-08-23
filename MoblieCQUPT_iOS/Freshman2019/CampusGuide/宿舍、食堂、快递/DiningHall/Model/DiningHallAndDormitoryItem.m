//
//  DiningHallItem.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/18.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "DiningHallAndDormitoryItem.h"

@implementation DiningHallAndDormitoryItem

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        self.rollImageFrame = CGRectMake(33, 33, MAIN_SCREEN_W - 66, (MAIN_SCREEN_W - 36) * 0.618);
        
//        CGFloat titleLabel_Y = /*CGRectGetMaxY(self.rollImageFrame)*/self.rollImageFrame.size.height + 15+10;
        CGFloat titleLabel_Y = CGRectGetMaxY(self.rollImageFrame) + 5;

        self.titleLabelFrame = CGRectMake(18, titleLabel_Y, MAIN_SCREEN_W - 66, 13);
        
        CGFloat detail_Y = CGRectGetMaxY(self.titleLabelFrame) + 8;
        NSDictionary *detailAtt = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
//        CGSize detailSiz
        
        CGSize detailSize = CGSizeMake(MAIN_SCREEN_W - 66, MAXFLOAT);
        CGFloat detailH = [self.detail boundingRectWithSize:detailSize options:NSStringDrawingUsesLineFragmentOrigin attributes:detailAtt context:nil].size.height;
        self.detailLabelFrame = CGRectMake(18, detail_Y, MAIN_SCREEN_W - 66, detailH);
        
        CGFloat detailMaxY = CGRectGetMaxY(self.detailLabelFrame);
        self.backgroundFrame = CGRectMake(15, 15, MAIN_SCREEN_W - 30, detailMaxY + 20);
        
        _cellHeight = CGRectGetMaxY(self.backgroundFrame) + 20;
    }
    return _cellHeight;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.detail = dict[@"detail"];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSString *image in dict[@"photo"]) {
            [tempArray addObject:[NSString stringWithFormat:@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/%@", image]];
        }
        self.rollImageURL = tempArray;
    }
    return self;
}

+ (instancetype)diningHallWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
