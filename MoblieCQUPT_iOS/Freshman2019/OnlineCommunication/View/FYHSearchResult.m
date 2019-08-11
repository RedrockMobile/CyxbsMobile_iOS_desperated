//
//  FYHSearchResult.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/3.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHSearchResult.h"

@interface FYHSearchResult ()

@end

@implementation FYHSearchResult

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0/7];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
    }
    return self;
}

@end
