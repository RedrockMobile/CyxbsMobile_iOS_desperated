//
//  GGCellModel.m
//  GGTableViewCell
//
//  Created by GQuEen on 16/8/13.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import "GGCellModel.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@implementation GGCellModel


- (instancetype)initWithContentData:(NSString *)data {
    if (self = [super init]) {
        self.contentData = data;
        self.cellType = 0;
        CGRect rect1 = [data boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        CGRect rect2 = [@"one" boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        
        self.expendHeigh = rect1.size.height + 55;
        
        CGFloat normalTextHeight = rect1.size.height >= 4 * rect2.size.height ? 4 * rect2.size.height : rect1.size.height;
        self.normalHeigh = normalTextHeight + 55;
        
        self.cellHeigh = self.normalHeigh;
    }
    return self;
}

@end
