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
@property (strong, nonatomic) UIView *beyondView;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *deadTimeLabel;
@property (strong, nonatomic) UILabel *descriptionsLabel;
@property (strong, nonatomic) UILabel *soreLabel;
@property (strong, nonatomic) UIImageView *genderImageView;
@property (strong, nonatomic) UIImageView *soreImageView;


@end
@implementation YouWenTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andDic: (NSDictionary *)dic
{
    static NSString *identify = @"YouWenTableViewCell";
    YouWenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[YouWenTableViewCell alloc] initWithReuseIdentifier:identify WithDic:(NSDictionary *)dic];
    }
    
    return cell;
}

- (instancetype) initWithReuseIdentifier:(NSString *)identify WithDic:(NSDictionary *)dic{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify]){
        self.dataDic = dic;
        [self workOutSize];
        [self setUpCell];
        self.frame = CGRectMake(0, 0, SCREENWIDTH, 350);
    }
    return self;
}

- (void)workOutSize{
    CGSize size = CGSizeMake(ScreenWidth - 30, 300);
    UIFont* font = [UIFont fontWithName:@"Arial" size:15];
    NSDictionary *dic = @{NSFontAttributeName:font};
    NSString *string = _dataDic[@"description"];
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin
        attributes:dic context:nil].size.height;
    _cellSize = CGRectMake(0, 0, ScreenWidth, height + 98);
}

- (void)setUpCell{
    self.backgroundColor = [UIColor clearColor];
    _beyondView = [[UIView alloc] initWithFrame: CGRectMake(10, 10, ScreenWidth - 20, _cellSize.size.height - 20)];
    _beyondView.backgroundColor = [UIColor whiteColor];
    _beyondView.layer.cornerRadius = 10;
    _beyondView.layer.masksToBounds = NO;
    _beyondView.layer.shadowColor = [UIColor grayColor].CGColor;
    _beyondView.layer.shadowOpacity = 0.2;
    _beyondView.layer.shadowOffset = CGSizeMake(1, 1);
    _beyondView.layer.shadowRadius = 3;
    [self.contentView addSubview:_beyondView];
    [self setUpDetail];
}

- (void)setUpDetail{
    _nameLabel = [[UILabel alloc] init];
    _headImageView = [[UIImageView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _descriptionsLabel = [[UILabel alloc] init];
    _soreLabel = [[UILabel alloc] init];
    _genderImageView = [[UIImageView alloc] init];
    _soreImageView = [[UIImageView alloc] init];
    _deadTimeLabel = [[UILabel alloc] init];
    
    NSArray *array = @[@"nickname", @"title", @"reward", @"description", @"disappear_at"];
    NSArray<UILabel *> *labelArray = @[_nameLabel, _titleLabel, _soreLabel, _descriptionsLabel, _deadTimeLabel];
    for (int i = 0; i < labelArray.count; i ++) {
        //判读空值
        if ([self.dataDic containsObjectForKey:array[i]]) {
            if (i == 2) {
                labelArray[i].text = [NSString stringWithFormat:@"%.0f积分", [self.dataDic[array[i]] doubleValue]];
            }
            else if (i == 1 && [self.dataDic[array[i]] hasPrefix :@"#"]){
                NSString *temp = self.dataDic[array[i]][0];
                NSRange blueRange = [temp rangeOfString:@"^##$" options:NSRegularExpressionSearch];
                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:temp];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:blueRange];
                labelArray[i].attributedText = attrString;
            }
            else if (i == 4){
                NSString *temp = [[NSString alloc] initWithFormat:@"%@小时后消失", [self countHour: self.dataDic[array[i]]]];
                labelArray[i].text = temp;
            }
            else{
                labelArray[i].text = self.dataDic[array[i]];
            }
        }
    }
    
    _descriptionsLabel.numberOfLines = 0;
    _descriptionsLabel.textAlignment = NSTextAlignmentLeft;
    _soreImageView.image = [UIImage imageNamed:@"soreImage"];
    NSString *genderStr = ([self.dataDic[@"gender"] isEqualToString:@"男"])?@"male":@"female";
    _genderImageView.image = [UIImage imageNamed:genderStr];

    _nameLabel.font = [UIFont fontWithName:@"Arial" size:12];
    _titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    _soreLabel.font = [UIFont fontWithName:@"Arial" size:10];
    _descriptionsLabel.font = [UIFont fontWithName:@"Arial" size:10];
    _deadTimeLabel.font = [UIFont fontWithName:@"Arial" size:10];
    
    [_beyondView addSubview:_nameLabel];
    [_beyondView addSubview:_titleLabel];
    [_beyondView addSubview:_headImageView];
    [_beyondView addSubview:_descriptionsLabel];
    [_beyondView addSubview:_soreLabel];
    [_beyondView addSubview:_genderImageView];
    [_beyondView addSubview:_soreImageView];
    [_beyondView addSubview:_deadTimeLabel];
    
    [_headImageView sd_setImageWithURL:self.dataDic[@"photo_thumbnail_src"] placeholderImage:nil];
    _headImageView.layer.cornerRadius = 13;
    _headImageView.layer.masksToBounds = YES;
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beyondView).mas_offset(10);
        make.left.equalTo(self.beyondView).mas_offset(10);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(26);
    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beyondView).mas_offset(10);
        make.left.equalTo(self.headImageView.mas_right)
        .mas_offset(2);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(18);
    }];
    
    [_genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beyondView).mas_offset(10);
        make.left.equalTo(self.nameLabel.mas_right).mas_equalTo(2);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [_deadTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(2);
        make.left.equalTo(self.headImageView.mas_right)
        .mas_offset(2);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(10);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom)
        .mas_offset(8);
        make.left.equalTo(self.beyondView).mas_offset(10);
        make.right.equalTo(self.beyondView).mas_offset(-10);
        make.height.mas_equalTo(20);
    }];

    [_soreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.beyondView).mas_offset(15);
        make.right.equalTo(self.beyondView).mas_offset(-5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(10);
    }];
    [_soreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beyondView).mas_offset(15);
        make.right.equalTo(self.soreLabel.mas_left).mas_offset(-2);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [_descriptionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom)
        .mas_offset(5);
        make.left.equalTo(self.beyondView).mas_offset(10);
        make.right.equalTo(self.beyondView).mas_offset(-10);
        make.height.mas_equalTo(_cellSize.size.height - 98);
    }];
    
    

}
- (NSString *)countHour:(NSString *)string{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *deadDate = [formatter dateFromString:string];
    NSTimeInterval time = [deadDate timeIntervalSinceDate:nowDate];
    NSInteger hour = time / 360;
    return [NSString  stringWithFormat:@"%ld", hour];
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
