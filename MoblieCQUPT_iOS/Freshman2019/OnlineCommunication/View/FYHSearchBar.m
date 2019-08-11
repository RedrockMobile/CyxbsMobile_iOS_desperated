//
//  FYHSearchBar.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/4.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHSearchBar.h"

@implementation FYHSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;

        UIImageView *searchBarBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        searchBarBackground.image = [UIImage imageNamed:@"搜索"];
        [self addSubview:searchBarBackground];
        
        UIImageView *scope = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 23, 23)];
        scope.image = [UIImage imageNamed:@"放大镜"];
        [searchBarBackground addSubview:scope];
        
        UITextField *searchBar = [[UITextField alloc] initWithFrame: CGRectMake(53, 0, w - 53, h)];
        searchBar.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        searchBar.font = [UIFont systemFontOfSize:15];
        [self addSubview:searchBar];
        self.textField = searchBar;
    }
    return self;
}

@end
