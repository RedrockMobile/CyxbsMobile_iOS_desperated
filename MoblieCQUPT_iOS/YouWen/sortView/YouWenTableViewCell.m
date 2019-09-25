//
//  YouWenTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenTableViewCell.h"
#import <Masonry.h>
#import <SDWebImageManager.h>
@interface YouWenTableViewCell()
@property (strong, nonatomic) UIView *backgrondView;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *deadTimeLabel;
@property (strong, nonatomic) UILabel *descriptionsLabel;
@property (strong, nonatomic) UILabel *soreLabel;
@property (strong, nonatomic) UIImageView *soreImageView;


@end
@implementation YouWenTableViewCell

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _dataDic = dic;
        _qusId = [[NSString alloc] initWithFormat:@"%@", dic[@"id"]];
        _title = [[NSString alloc] initWithFormat:@"%@", dic[@"title"]];
        [self setUpCell];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 350);
    }
    [self layoutIfNeeded];
    return self;
}

- (void)setUpCell{
    self.backgroundColor = [UIColor clearColor];
    _backgrondView = [[UIView alloc] init];
    _backgrondView.backgroundColor = [UIColor whiteColor];
    _backgrondView.layer.cornerRadius = 10;
    _backgrondView.layer.masksToBounds = NO;
    _backgrondView.layer.shadowColor = [UIColor grayColor].CGColor;
    _backgrondView.layer.shadowOpacity = 0.2;
    _backgrondView.layer.shadowOffset = CGSizeMake(1, 1);
    _backgrondView.layer.shadowRadius = 3;
    [self.contentView addSubview:_backgrondView];
    [self setUpDetail];
}

- (void)setUpDetail{
    _nameLabel = [[UILabel alloc] init];
    _headImageView = [[UIImageView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _descriptionsLabel = [[UILabel alloc] init];
    _soreLabel = [[UILabel alloc] init];
    _soreImageView = [[UIImageView alloc] init];
    _deadTimeLabel = [[UILabel alloc] init];
    
    NSArray *array = @[@"nickname", @"title", @"reward", @"description", @"disappear_at"];
    NSArray<UILabel *> *labelArray = @[_nameLabel, _titleLabel, _soreLabel, _descriptionsLabel, _deadTimeLabel];
    
   
    _soreImageView.image = [UIImage imageNamed:@"soreImage"];
    
    _nameLabel.font = [UIFont fontWithName:@"Arial" size:13];
    _nameLabel.textColor = [UIColor colorWithHexString:@"555555"];
    
    _titleLabel.font = [UIFont fontWithName:@"Arial" size:17];
    _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    _soreLabel.font = [UIFont fontWithName:@"Arial" size:12];
    _soreLabel.textColor = [UIColor colorWithHexString:@"777777"];
    
    _descriptionsLabel.font = [UIFont fontWithName:@"Arial" size:11];
    _descriptionsLabel.textColor = [UIColor colorWithHexString:@"555555"];
    _descriptionsLabel.numberOfLines = 0;
    _descriptionsLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    
    _deadTimeLabel.font = [UIFont fontWithName:@"Arial" size:11];
    _deadTimeLabel.textColor = [UIColor colorWithHexString:@"999999"];
    
    for (int i = 0; i < labelArray.count; i ++) {
        //判读空值
        if ([self.dataDic containsObjectForKey:array[i]]) {
            NSString *tag = [[NSString alloc] initWithString:self.dataDic[@"tags"]];
            if (i == 2) {
                labelArray[i].text = [NSString stringWithFormat:@"%.0f积分", [self.dataDic[array[i]] doubleValue]];
            }
            else if (i == 1){
                NSMutableAttributedString *attrString;
                if (tag.length != 0) {
                    attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"#%@# ", tag]];
                    [attrString appendString:self.dataDic[array[i]]];
                    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"7195FA"] range:NSMakeRange(0, tag.length + 2)];
                }
                else {
                    attrString = [[NSMutableAttributedString alloc] initWithString:self.dataDic[array[i]]];
                }
                _titleLabel.attributedText = attrString;
            }
            else if (i == 4){
                NSInteger timeLeft = [[self countHour: self.dataDic[array[i]]] integerValue];
                if (timeLeft <= 24) {
                    NSString *temp = [[NSString alloc] initWithFormat:@"%ld小时后消失", timeLeft];
                    labelArray[i].text = temp;
                } else {
                    NSString *temp = [[NSString alloc] initWithFormat:@"%ld天后消失", timeLeft / 24];
                    labelArray[i].text = temp;
                }
            }
            else{
                labelArray[i].text = self.dataDic[array[i]];
            }
        }
    }
    
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_headImageView];
    [self.contentView addSubview:_descriptionsLabel];
    [self.contentView addSubview:_soreLabel];
    [self.contentView addSubview:_soreImageView];
    [self.contentView addSubview:_deadTimeLabel];
    
    [_headImageView sd_setImageWithURL:self.dataDic[@"photo_thumbnail_src"] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _headImageView.layer.cornerRadius = 13;
    _headImageView.layer.masksToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top)
        .mas_offset(20);
        make.left.equalTo(self.contentView.mas_left)
        .mas_offset(25);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top)
        .mas_offset(20);
        make.left.equalTo(self.headImageView.mas_right)
        .mas_offset(17);
        make.height.mas_equalTo(13);
    }];
    
    [_deadTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom)
        .mas_offset(5);
        make.left.equalTo(self.headImageView.mas_right)
        .mas_offset(17);
        make.height.mas_equalTo(11);
        make.height.mas_lessThanOrEqualTo(100);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom)
        .mas_offset(10);
        make.left.equalTo(self.contentView.mas_left)
        .mas_offset(25);
        make.right.equalTo(self.contentView.mas_right)
        .mas_offset(-25);
        make.height.mas_lessThanOrEqualTo(100);
    }];
    
    [_soreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView.mas_top)
        .mas_offset(27);
        make.right.equalTo(self.contentView.mas_right)
        .mas_offset(-30);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(12);
    }];
    
    [_soreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.soreLabel.mas_bottom);
        make.right.equalTo(self.soreLabel.mas_left)
        .mas_offset(-4);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    [_descriptionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom)
        .mas_offset(5);
        make.left.equalTo(self.contentView.mas_left)
        .mas_offset(25);
        make.right.equalTo(self.contentView.mas_right)
        .mas_offset(-25);
        make.bottom.equalTo(self.contentView.mas_bottom)
        .mas_offset(-20);
        make.height.mas_lessThanOrEqualTo(100);
    }];
    
    [self layoutIfNeeded];
    /*使用Masonry会因为还没有约束，而不起作用，解决方法直接取frame，
     整体内缩
     */
    _backgrondView.frame = CGRectMake(10, 5, self.contentView.width - 20, self.contentView.height - 10);
}


- (NSString *)countHour:(NSString *)string{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *deadDate = [formatter dateFromString:string];
    NSTimeInterval time = [deadDate timeIntervalSinceDate:nowDate];
    NSInteger hour = time / 3600;
    return [NSString  stringWithFormat:@"%ld", hour];
}
@end
