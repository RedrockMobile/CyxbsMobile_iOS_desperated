//
//  BeforeClassCell.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/12.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "BeforeClassCell.h"
@interface BeforeClassCell()

@property (strong, nonatomic)UILabel *nameLab;
@property (strong, nonatomic)UILabel *detailLab;

@end
@implementation BeforeClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Andstate:(NSString *)state{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    }
    if ([state isEqualToString:@"remindMeTime"]||[state isEqualToString:@"remindMeBeforeTime"]) {
        [self loadNormalView:state];
    }
    else{
        [self loadExtraView];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView AndStyle:(NSString *)style
{
    static NSString *identify = @"ClassCell";
    BeforeClassCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {

        cell = [[BeforeClassCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify Andstate:style];

    }
    return cell;
}
- (void)loadContent{
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(18, 18, 100, 16)];
    _nameLab.font = [UIFont fontWithName:@"Arial" size:16];
    _nameLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLab];
    _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(18, _nameLab.bottom + 10, 250, 16)];
    _detailLab.font = [UIFont fontWithName:@"Arial" size:14];
    _detailLab.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_detailLab];

}
- (void)loadNormalView:(NSString *)state{
    [self loadContent];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    switchview.onTintColor = [UIColor colorWithRed:120/255.0 green:142/255.0 blue:250/255.0 alpha:1.0];
    [switchview addTarget:self action:@selector(switchValueChanged) forControlEvents:UIControlEventValueChanged];
    self.style = state;
    if (![userDefault objectForKey:[NSString stringWithFormat:@"%@BOOL",state]]) {
        switchview.on = NO;
        _state = NO;
        [userDefault setBool:NO forKey:[NSString stringWithFormat:@"%@BOOL",state]];
        if ([state isEqualToString:@"remindMeTime"]) {
            [userDefault setObject:@"19:00" forKey:state];
        }
        else{
            [userDefault setObject:@"10" forKey:state];
        }
    }
    else{
        _state = [[userDefault objectForKey:[NSString stringWithFormat:@"%@BOOL",state]] intValue];
        switchview.on = [[userDefault objectForKey:[NSString stringWithFormat:@"%@BOOL",state]] intValue];
    }
    self.accessoryView = switchview;
}
- (void)switchValueChanged{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"state" object:_style];
}
- (void)loadExtraView{
    if (_state == YES) {
        [self loadContent];
         self.userInteractionEnabled = YES;
    }
    else{
        self.userInteractionEnabled = NO;
        [self loadContent];
        self.nameLab.textColor = [UIColor colorWithHexString:@"999999"];
        self.detailLab.textColor = [UIColor colorWithHexString:@"999999"];
    }

}

- (void)setState:(BOOL)state{
    _state = state;
    if (state == YES) {
        self.userInteractionEnabled = YES;
        self.nameLab.textColor = [UIColor colorWithHexString:@"666666"];
        self.detailLab.textColor = [UIColor colorWithHexString:@"666666"];
    }
    else{
        self.userInteractionEnabled = NO;
        self.nameLab.textColor = [UIColor colorWithHexString:@"999999"];
        self.detailLab.textColor = [UIColor colorWithHexString:@"999999"];
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:state forKey:[NSString stringWithFormat:@"%@BOOL", self.style]];
}
- (void)setNameString:(NSString *)nameString{
    _nameLab.text = nameString;
    
}
- (void)setDetailString:(NSString *)detailString{
    _detailLab.text = detailString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
