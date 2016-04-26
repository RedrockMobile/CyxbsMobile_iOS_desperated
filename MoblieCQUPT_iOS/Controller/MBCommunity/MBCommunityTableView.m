//
//  MBCommunityTableView.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityTableView.h"
#import "MBCommunityCellTableViewCell.h"

@implementation MBCommunityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
