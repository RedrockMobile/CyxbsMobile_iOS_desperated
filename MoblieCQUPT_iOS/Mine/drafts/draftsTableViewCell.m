//
//  draftsTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/2.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "draftsTableViewCell.h"
@interface draftsTableViewCell()
@property (nonatomic, strong) UILabel *mainLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *timeLab;
@end

@implementation draftsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView AndLab:(BOOL)whether
{
    static NSString *identify = @"draftsCell";
    draftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[draftsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify AndLab:whether];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndLab:(BOOL)whether{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpLab:whether];
    }
    
    return self;
}

- (void)setUpLab:(BOOL)whether{
    _mainLab = [[UILabel alloc] init];
    _detailLab = [[UILabel alloc] init];
    _timeLab = [[UILabel alloc] init];
    
    _mainLab.textColor = [UIColor blackColor];
    _detailLab.textColor = RGBColor(85, 85, 85, 1);
    _timeLab.textColor = RGBColor(136, 136, 136, 1);
    
    _mainLab.text = @"Name";
    _detailLab.text = @"Detail";
    _timeLab.text = @"time";
    
    _mainLab.font = [UIFont fontWithName:@"Arial" size:15];
    _detailLab.font = [UIFont fontWithName:@"Arial" size:14];
    _timeLab.font = [UIFont fontWithName:@"Arial" size:12];
    [self addSubview:_mainLab];
    [self addSubview:_timeLab];
    
    [_mainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(15);
        make.right.mas_equalTo(self).mas_offset(-15);
        make.top.mas_equalTo(self).mas_offset(20);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(15);
        make.right.mas_equalTo(self).mas_offset(-15);
        make.bottom.mas_equalTo(self).mas_offset(-100);
    }];
    
    if (whether) {
        [self addSubview:_detailLab];
        [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(15);
            make.right.mas_equalTo(self).mas_offset(-15);
            make.top.mas_equalTo(_mainLab).mas_offset(10);
            make.bottom.mas_equalTo(_timeLab).mas_offset(-10);
        }];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
