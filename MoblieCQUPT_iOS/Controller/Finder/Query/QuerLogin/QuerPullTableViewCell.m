//
//  QuerPullTableViewCell.m
//  Query
//
//  Created by hzl on 2017/3/7.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerPullTableViewCell.h"
#import "AppDelegate.h"

#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){

    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleY;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@implementation QuerPullTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identify = @"cell";
    QuerPullTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[QuerPullTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    return cell;
}

- (void)setUpUI{
    _guideLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(15, 18, self.bounds.size.width, self.bounds.size.height)];
    _guideLabel.contentMode = UIViewContentModeCenter;
    _guideLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    _guideLabel.font = [UIFont systemFontOfSize:font(16)];
    _guideLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_guideLabel];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
