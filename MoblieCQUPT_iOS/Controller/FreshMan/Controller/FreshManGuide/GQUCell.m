//
//  GQUCell.m
//  GGTableViewCell
//
//  Created by GQuEen on 16/8/13.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import "GQUCell.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//#define MAIN_COLOR [UIColor colorWithRed:204/255.0 green:254/255.0 blue:198/255.0 alpha:1]

@interface GQUCell ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UILabel *headLabel;
@property (strong, nonatomic) UILabel *normalContentLabel;
@property (strong, nonatomic) UILabel *expendContentLabel;
@property (strong, nonatomic) UIView *underLine;

@property (strong, nonatomic) UIImageView *headTipImageView;

@end


@implementation GQUCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupContentView {
    _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 0, 0)];
    _headLabel.font = [UIFont systemFontOfSize:15];
    
    _headTipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _headTipImageView.image = [UIImage imageNamed:@"arrow.png"];
    _headTipImageView.frame = CGRectMake(ScreenWidth - self.headTipImageView.frame.size.width-15, 15, self.headTipImageView.frame.size.width, self.headTipImageView.frame.size.height);
     _normalContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, ScreenWidth-20, 0)];
    _normalContentLabel.numberOfLines = 4;
    _normalContentLabel.font = [UIFont systemFontOfSize:13];
    _normalContentLabel.textColor = [UIColor grayColor];
    _expendContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, ScreenWidth-20, 0)];
    _expendContentLabel.numberOfLines = 0;
    _expendContentLabel.font = [UIFont systemFontOfSize:13];
    _expendContentLabel.textColor = [UIColor grayColor];
    _expendContentLabel.alpha = 0;
    
    _underLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-1, ScreenWidth, 1)];
    _underLine.backgroundColor = [UIColor colorWithRed:226/255.0 green:227/255.0 blue:228/255.0 alpha:1];
    
    [self.contentView addSubview:_headLabel];
    [self.contentView addSubview:_headTipImageView];
    [self.contentView addSubview:_normalContentLabel];
    [self.contentView addSubview:_expendContentLabel];
    [self.contentView addSubview:_underLine];
}

- (void)setModel:(GGCellModel *)model {
    _model = model;
    [self setupData];
}

- (void)setupData {
    _normalContentLabel.text = self.model.contentData;
    _expendContentLabel.text = self.model.contentData;
    
    _headLabel.text = self.headTitle;
    
    [_headLabel sizeToFit];
    [_normalContentLabel sizeToFit];
    [_expendContentLabel sizeToFit];
    
    _underLine.frame = CGRectMake(0, self.model.cellHeigh-1, ScreenWidth, 1);
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identify = @"GGCell";
    GQUCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[GQUCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.tableView = tableView;
        
    }
    return cell;
}

- (void)clickCell {
//    NSLog(@"click cell:%ld",self.cellType);
    switch (self.cellType) {
        case GGShowCellTextTypeExpend:
            
            self.cellType = GGShowCellTextTypeNormal;
            self.model.cellHeigh = self.model.normalHeigh;
            self.model.cellType = GGShowCellTextTypeNormal;
            [self cellChangeAnimate:0];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            break;
        case GGShowCellTextTypeNormal:
            self.cellType = GGShowCellTextTypeExpend;
            self.model.cellHeigh = self.model.expendHeigh;
            self.model.cellType = GGShowCellTextTypeExpend;
            [self cellChangeAnimate:1];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        default:
            break;
    }
}
- (void)cellChangeAnimate:(NSInteger)state{
    if (state == 0) {
        [UIView animateWithDuration:0.2f animations:^{
            self.expendContentLabel.alpha = 0;
            self.normalContentLabel.alpha = 1;
            _underLine.frame = CGRectMake(0, self.model.cellHeigh-1, ScreenWidth, 1);
        }];
        _headTipImageView.transform = CGAffineTransformMakeRotation(0);
    }else if (state == 1) {
        [UIView animateWithDuration:0.2f animations:^{
            self.expendContentLabel.alpha = 1;
            self.normalContentLabel.alpha = 0;
            _underLine.frame = CGRectMake(0, self.model.cellHeigh-1, ScreenWidth, 1);
        }];
        _headTipImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
