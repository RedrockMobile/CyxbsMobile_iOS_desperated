//
//  ListTableViewCell.m
//  选课名单
//
//  Created by 丁磊 on 2018/9/19.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "ListTableViewCell.h"
#import "ListModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667

@implementation ListTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier: reuseIdentifier])
    {
        UIImageView *bkg = [[UIImageView alloc]initWithFrame:CGRectMake(15*WIDTH, 15*HEIGHT, 345*WIDTH, 85*HEIGHT)];
        bkg.image = [UIImage imageNamed:@"white_bkg"];
        bkg.backgroundColor = [UIColor clearColor];
        bkg.layer.shadowColor = [UIColor blackColor].CGColor;
        bkg.layer.shadowOffset = CGSizeMake(0, 0);
        bkg.layer.shadowOpacity = 0.05;
        bkg.layer.shadowRadius = 4.5;
        [self.contentView addSubview:bkg];
        self.bkg = bkg;
        
        self.MoreBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, 45, 30, 30)];
        [self.MoreBtn setImage:[UIImage imageNamed:@"downward"] forState:UIControlStateNormal];
        [self.MoreBtn addTarget:self action:@selector(showMoreText:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.MoreBtn];
        
        self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 20*HEIGHT, 200*WIDTH, 50*HEIGHT)];
        self.nameLab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:17*HEIGHT];
        self.nameLab.numberOfLines = 2;
        [self.contentView addSubview:self.nameLab];
        
        self.stuNumLab = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 65*HEIGHT, 250*WIDTH, 20*HEIGHT)];
        self.stuNumLab.font = [UIFont systemFontOfSize:13*HEIGHT];
        self.stuNumLab.textAlignment = NSTextAlignmentLeft;
        self.stuNumLab.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.stuNumLab];
        
        self.schoolLab = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 210*HEIGHT, 250*WIDTH, 20*HEIGHT)];
        self.schoolLab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13*HEIGHT];
        self.schoolLab.textAlignment = NSTextAlignmentLeft;
        self.schoolLab.textColor = [UIColor darkGrayColor];
        
        self.lab1 = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 120*HEIGHT, 70*WIDTH, 20*HEIGHT)];
        self.lab1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13*HEIGHT];
        self.lab1.textAlignment = NSTextAlignmentLeft;
        self.lab1.text = @"年级：";
        self.lab1.textColor = [UIColor darkGrayColor];

        self.year = [[UILabel alloc] initWithFrame:CGRectMake(110*WIDTH, 120*HEIGHT, 100*WIDTH, 20*HEIGHT)];
        self.year.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13*HEIGHT];
        self.year.textAlignment = NSTextAlignmentLeft;
        self.year.textColor = [UIColor darkGrayColor];
        self.lab2 = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 180*HEIGHT, 70*WIDTH, 20*HEIGHT)];
        self.lab2.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13*HEIGHT];
        self.lab2.textAlignment = NSTextAlignmentLeft;
        self.lab2.text = @"专业：";
        self.lab2.textColor = [UIColor darkGrayColor];
        
        self.majorLab = [[UILabel alloc] initWithFrame:CGRectMake(110*WIDTH, 180*HEIGHT, 200*WIDTH, 20*HEIGHT)];
        self.majorLab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13*HEIGHT];
        self.majorLab.textAlignment = NSTextAlignmentLeft;
        self.majorLab.textColor = [UIColor darkGrayColor];
        self.lab3 = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 150*HEIGHT, 70*WIDTH, 20*HEIGHT)];
        self.lab3.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13*HEIGHT];
        self.lab3.textAlignment = NSTextAlignmentLeft;
        self.lab3.text = @"班级：";
        self.lab3.textColor = [UIColor darkGrayColor];
        self.classIdLab = [[UILabel alloc] initWithFrame:CGRectMake(110*WIDTH, 150*HEIGHT, 200*WIDTH, 20*HEIGHT)];
        self.classIdLab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14*HEIGHT];
        self.classIdLab.textAlignment = NSTextAlignmentLeft;
        self.classIdLab.textColor = [UIColor darkGrayColor];
        self.lab4 = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 90*HEIGHT, 70*WIDTH, 20*HEIGHT)];
        self.lab4.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13*HEIGHT];
        self.lab4.textAlignment = NSTextAlignmentLeft;
        self.lab4.text = @"性别：";
        self.lab4.textColor = [UIColor darkGrayColor];
        self.stuSecLab = [[UILabel alloc] initWithFrame:CGRectMake(110*WIDTH, 90*HEIGHT, 200*WIDTH, 20*HEIGHT)];
        self.stuSecLab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14*HEIGHT];
        self.stuSecLab.textAlignment = NSTextAlignmentLeft;
        self.stuSecLab.textColor = [UIColor darkGrayColor];
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)showMoreText:(UIButton *)sender{
    
    self.Model.isShowMore = !self.Model.isShowMore;
    
    if (self.showTextBlock) {
        self.showTextBlock(self);
    }
    
}

+ (CGFloat)cellDefautHeight{
    return 100*HEIGHT;
}

+ (CGFloat)cellMoreHeight{
    return 250*HEIGHT;
}

- (void)setModel:(ListModel *)Model{
    _Model = Model;
    _nameLab.text = self.Model.stuName;
    _stuNumLab.text = [NSString stringWithFormat:@"学号：      %@",self.Model.stuNum];
    _schoolLab.text = [NSString stringWithFormat:@"学院：     %@",self.Model.school];
    if (self.Model.isShowMore) {
        _bkg.image = [UIImage imageNamed:@"unfold_white_bkg"];
        _bkg.frame = CGRectMake(15*WIDTH, 15*HEIGHT, 345*WIDTH, 235*HEIGHT);
        [_MoreBtn setImage:[UIImage imageNamed:@"upward"] forState:UIControlStateNormal];
        _year.text = self.Model.year;
        _stuSecLab.text = self.Model.stuSex;
        _majorLab.text = self.Model.major;
        _classIdLab.text = self.Model.classId;
        [self.contentView addSubview:self.schoolLab];
        [self.contentView addSubview: _year];
        [self.contentView addSubview: _classIdLab];
        [self.contentView addSubview: _majorLab];
        [self.contentView addSubview: _stuSecLab];
        [self.contentView addSubview: _lab1];
        [self.contentView addSubview: _lab2];
        [self.contentView addSubview: _lab3];
        [self.contentView addSubview: _lab4];
    }
    else{
        [_MoreBtn setImage:[UIImage imageNamed:@"downward"] forState:UIControlStateNormal];
        _bkg.frame = CGRectMake(15*WIDTH, 15*HEIGHT, 345*WIDTH, 85*HEIGHT);
        [_year removeFromSuperview];
        [_classIdLab removeFromSuperview];
        [_majorLab removeFromSuperview];
        [_stuSecLab removeFromSuperview];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexpath:(NSIndexPath *)indexPath
{
    NSString *Identifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (ListTableViewCell *)cell;
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
