//
//  ExpressSpotItem.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/17.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ExpressSpotItem.h"

@implementation ExpressSpotItem

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        self.ImageFrame = CGRectMake(33, 33, MAIN_SCREEN_W - 66, (MAIN_SCREEN_W - 66) * 0.618);
        
//        CGFloat titleLabel_Y = CGRectGetMaxY(self.ImageFrame) + 15;
        CGFloat titleLabel_Y = /*CGRectGetMaxY(self.rollImageFrame)*/self.ImageFrame.size.height + 15+10;
        self.titleLabelFrame = CGRectMake(18, titleLabel_Y, MAIN_SCREEN_W - 66, 13);
        
        CGFloat detail_Y = CGRectGetMaxY(self.titleLabelFrame) + 8;
        NSDictionary *detailAtt = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        
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
        self.spotName = dict[@"title"];
        self.detail = dict[@"detail"];
        self.photo = [NSString stringWithFormat:@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/%@", dict[@"photo"]];
    }
    return self;
}

+ (instancetype)spotWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
