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
        UIImageView *bkg = [[UIImageView alloc]initWithFrame:CGRectMake(15*WIDTH, 15*HEIGHT, 345*WIDTH, 52*HEIGHT)];
        bkg.image = [UIImage imageNamed:@"白底"];
        bkg.backgroundColor = [UIColor clearColor];
        bkg.layer.shadowColor = [UIColor blackColor].CGColor;
        bkg.layer.shadowOffset = CGSizeMake(0, 0);
        bkg.layer.shadowOpacity = 0.05;
        bkg.layer.shadowRadius = 4.5;
        [self.contentView addSubview:bkg];
        self.bkg = bkg;
        
        
        UIButton *btn1 = [[UIButton alloc]init];
        btn1.frame = CGRectMake(30*WIDTH, 33*HEIGHT, 19*WIDTH, 19*HEIGHT);
        [btn1 setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
        self.btn1 = btn1;
        
        UIButton *btn3 = [[UIButton alloc]init];
        btn3.frame = CGRectMake(30*WIDTH, 33*HEIGHT, 19*WIDTH, 19*HEIGHT);
        [btn3 setImage:[UIImage imageNamed:@"删除蓝框"] forState:UIControlStateNormal];
        self.btn3 = btn3;
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(63*WIDTH, 33*HEIGHT, width-150, 16*HEIGHT);
        label.textColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.2000 alpha:1.0];
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16*HEIGHT];
        [self.contentView addSubview: label];
        self.label = label;
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(63*WIDTH, 63*HEIGHT, 269*WIDTH, 0)];
        detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14*HEIGHT];
        detailLabel.numberOfLines = 0;
        detailLabel.textColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.4000 alpha:1.0];
        [self.contentView addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(332*WIDTH, 33*HEIGHT, 14*WIDTH, 19*HEIGHT)];
        [btn2 setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"向上"] forState:UIControlStateSelected];
        [btn2 addTarget:self action:@selector(showMoreText:) forControlEvents:UIControlEventTouchUpInside];
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
        [self setLabelSpace:_detailLabel withValue:self.DLNModel.detail withFont:14*HEIGHT];
        CGFloat height = [FMNecessityTableViewCell getStringHeight:self.DLNModel.detail font:14*HEIGHT];
        _detailLabel.hidden = NO;
        self.bkg.image = [UIImage imageNamed:@"展开白底"];
        self.bkg.frame = CGRectMake(15*WIDTH, 15*HEIGHT, 345*WIDTH, 65*HEIGHT+height);
        _detailLabel.frame = CGRectMake(63*WIDTH, 63*HEIGHT, 269*WIDTH, height);
        _btn2.selected = YES;
    }
    else{
        self.bkg.image = [UIImage imageNamed:@"白底"];
        self.bkg.frame = CGRectMake(15*WIDTH, 15*HEIGHT, 345*WIDTH, 52*HEIGHT);
        _detailLabel.frame = CGRectMake(63*WIDTH, 63*HEIGHT, 269*WIDTH, 0);
        _detailLabel.hidden = YES;
        self.btn2.selected = NO;
    }
    if (_DLNModel.isShowMoreBtn) {
        [self.contentView addSubview:self.btn2];
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
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = 3.0;
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:fontSize], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGRect rect = [string boundingRectWithSize:CGSizeMake(269*WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return ceil(rect.size.height);
}

+ (CGFloat)cellDefautHeight:(DLNecessityModel *)DLNModel {
    return 68*HEIGHT;
}

+ (CGFloat)cellMoreHeight:(DLNecessityModel *)DLNModel{
    return [FMNecessityTableViewCell getStringHeight:DLNModel.detail font:14*HEIGHT]+82*HEIGHT;
}



#pragma  - 设置label行间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(CGFloat)fontSize {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = 3.0; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };

    
    
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    
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
