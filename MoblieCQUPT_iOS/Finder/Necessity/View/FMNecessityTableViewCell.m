//
//  FMNecessityTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "FMNecessityTableViewCell.h"
#import "DLNecessityModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667

@implementation FMNecessityTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier: reuseIdentifier])
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.hidden = NO;
        UIImageView *bkg = [[UIImageView alloc]initWithFrame:CGRectMake(15*width, 15*HEIGHT, 345*width, 52*HEIGHT)];
        bkg.image = [UIImage imageNamed:@"白底"];
        bkg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bkg];
        self.bkg = bkg;
        
        
        UIButton *btn1 = [[UIButton alloc]init];
        btn1.frame = CGRectMake(30, 33, 25, 25);
        [btn1 setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
        self.btn1 = btn1;
        
        UIButton *btn3 = [[UIButton alloc]init];
        btn3.frame = CGRectMake(30, 33, 25, 25);
        [btn3 setImage:[UIImage imageNamed:@"删除蓝框"] forState:UIControlStateNormal];
        self.btn3 = btn3;
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(70, 20, width-150, 50);
        label.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview: label];
        self.label = label;
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, [UIScreen mainScreen].bounds.size.width-30, 0)];
        detailLabel.font = [UIFont systemFontOfSize:15];
        detailLabel.numberOfLines = 0;
        [self.contentView addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(width-60, 30, 20, 20)];
        [btn2 setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"向上"] forState:UIControlStateSelected];
        [btn2 addTarget:self action:@selector(showMoreText:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn2];
        self.btn2 = btn2;
        
        
    }
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexpath:(NSIndexPath *)indexPath
{
    NSString *Identifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    FMNecessityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[FMNecessityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (FMNecessityTableViewCell *)cell;
}

- (void)setDLNModel:(DLNecessityModel *)DLNModel{
    _DLNModel = DLNModel;
    _label.text = DLNModel.necessity;
    _detailLabel.text = DLNModel.detail;
    if (DLNModel.isShowMore){
        CGFloat height = [FMNecessityTableViewCell getStringHeight:self.DLNModel.detail font:15];
        _detailLabel.hidden = NO;
        self.bkg.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, height + 70);
        _detailLabel.frame = CGRectMake(30, 70, [UIScreen mainScreen].bounds.size.width-60, height);
        _btn2.selected = YES;
    }
    else{
        self.bkg.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 70);
        _detailLabel.frame = CGRectMake(30, 70, [UIScreen mainScreen].bounds.size.width-60, 0);
        _detailLabel.hidden = YES;
        self.btn2.selected = NO;
    }
}



#pragma - button方法



- (void)showMoreText:(UIButton *)sender{
    
    self.DLNModel.isShowMore = !self.DLNModel.isShowMore;
    
    if (self.showTextBlock) {
        self.showTextBlock(self);
    }
    
}
#pragma - 计算行高

+ (CGFloat)getStringHeight:(NSString *)string font:(CGFloat)fontSize {
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return ceil(rect.size.height);
}

+ (CGFloat)cellDefautHeight:(DLNecessityModel *)DLNModel {
    return 80;
}

+ (CGFloat)cellMoreHeight:(DLNecessityModel *)DLNModel{
    return [FMNecessityTableViewCell getStringHeight:DLNModel.detail font:15]+80;
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
