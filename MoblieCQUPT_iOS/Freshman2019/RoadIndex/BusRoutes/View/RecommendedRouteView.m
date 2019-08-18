//
//  RecommendedRouteView.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "RecommendedRouteView.h"

@implementation RecommendedRouteView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"推荐路线";
    titleLabel.textColor = RGBColor(153, 153, 153, 1);
    CGFloat fontSize;
    if(SCREEN_WIDTH > 375){
        fontSize = 16;
    }else{
        fontSize = 14;
    }
    titleLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    [backgroundView addSubview:titleLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, 50) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backgroundView addSubview:self.tableView];
    
    [self addSubview:backgroundView];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self).offset(9);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-15);
        
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(backgroundView).offset(0);
        make.left.equalTo(backgroundView).offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(70);
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.bottom.equalTo(backgroundView).offset(0);
        
    }];
    
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
