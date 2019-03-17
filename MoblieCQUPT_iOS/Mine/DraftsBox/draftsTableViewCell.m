//
//  draftsTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/2.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "draftsTableViewCell.h"
#import "draftsModel.h"

@interface draftsTableViewCell()
@property (nonatomic, strong) UILabel *mainLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) draftsModel *dataModel;
@end

@implementation draftsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView AndData:(draftsModel *)model
{
    static NSString *identify = @"draftsCell";
    draftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[draftsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify AndData:model];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndData:(draftsModel *)model{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.dataModel = model;
        [self setUpLab];
    }
    return self;
}


- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setUpLab{
    _mainLab = [[UILabel alloc] init];
    _detailLab = [[UILabel alloc] init];
    _timeLab = [[UILabel alloc] init];
    
    _mainLab.textColor = [UIColor blackColor];
    _detailLab.textColor = RGBColor(85, 85, 85, 1);
    _timeLab.textColor = RGBColor(136, 136, 136, 1);
    
    _mainLab.font = [UIFont fontWithName:@"Arial" size:15];
    _detailLab.font = [UIFont fontWithName:@"Arial" size:14];
    _timeLab.font = [UIFont fontWithName:@"Arial" size:12];
    [self.contentView addSubview:_mainLab];
    [self.contentView addSubview:_timeLab];
    [self.contentView addSubview:_detailLab];
    
    if (_dataModel.title_content.length) {
        
        _mainLab.text = [NSString stringWithFormat:@"%@：%@",[self transforWord:_dataModel.titleType] ,_dataModel.title_content];
        _detailLab.text = [NSString stringWithFormat:@"%@：%@", [self transforWord:_dataModel.type]
                           ,_dataModel.content];
    }
    else {
        _mainLab.text = [NSString stringWithFormat:@"%@：%@",[self transforWord:_dataModel.type] ,_dataModel.content];
    }
    _timeLab.text = _dataModel.create_time;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_mainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo
        (self.contentView.mas_top).offset(10);
        make.left.mas_equalTo
        (self.contentView.mas_left).offset(15);
        make.right.mas_equalTo
        (self.contentView.mas_right)
        .offset(-15);
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainLab.mas_bottom)
        .offset(8);
        make.left.mas_equalTo
        (self.contentView.mas_left).offset(15);
        make.right.mas_equalTo
        (self.contentView.mas_right).offset(-15);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailLab.mas_bottom)
        .offset(8);
        make.bottom.mas_equalTo
        (self.contentView.mas_bottom)
        .offset(-10);
        make.left.mas_equalTo(self.contentView)
        .offset(15);
        make.right.mas_equalTo(self.contentView)
        .offset(-15);
       
    }];
}

- (NSString *)transforWord:(NSString *)str{
    NSString *Tstr = [NSString string];
    if ([str isEqualToString:@"question"]) {
        Tstr = @"提问";
    }
    else if ([str isEqualToString:@"remark"]){
        Tstr = @"评论";
    }
    else {
        Tstr = @"帮助";
    }
    return Tstr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
