//
//  BackgroundTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 25/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import "BackgroundTableViewCell.h"

@implementation BackgroundTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"status";
    BackgroundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BackgroundTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 13,MAIN_SCREEN_W-32,180)];
        backgroundImageView.image = [UIImage imageNamed:@"背景板"];
//        backgroundImageView.backgroundColor = [UIColor clearColor];
        self.backgroundImageView = backgroundImageView;
        [self.contentView addSubview:backgroundImageView];
        
        int padding =160;
        UILabel *backgroundLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(padding, 59, MAIN_SCREEN_W-2*padding, 23)];
        backgroundLabel1.font = [UIFont systemFontOfSize:23];
        backgroundLabel1.text = @"时长";
        backgroundLabel1.textAlignment = NSTextAlignmentCenter;
        backgroundLabel1.textColor = [UIColor whiteColor];
        backgroundLabel1.backgroundColor = [UIColor clearColor];
        self.backgroundLabel1 = backgroundLabel1;
        [self.contentView addSubview:backgroundLabel1];
        int padding1 = 95;
        UILabel *backgroundLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_W-padding1-60,117, 60, 29)];
        backgroundLabel2.font = [UIFont systemFontOfSize:29];
        backgroundLabel2.text = @"小时";
        backgroundLabel2.textAlignment = NSTextAlignmentCenter;
        backgroundLabel2.textColor = [UIColor whiteColor];
        backgroundLabel2.backgroundColor = [UIColor clearColor];
        self.backgroundLabel2 = backgroundLabel2;
        [self.contentView addSubview:backgroundLabel2];
        
        UILabel *backgroundLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(padding1,107, 150, 40)];
        backgroundLabel3.font = [UIFont systemFontOfSize:40];
        backgroundLabel3.textAlignment = NSTextAlignmentCenter;
        backgroundLabel3.textColor = [UIColor whiteColor];
        backgroundLabel3.backgroundColor = [UIColor clearColor];
        self.backgroundLabel3 = backgroundLabel3;
        [self.contentView addSubview:backgroundLabel3];

    }
    return self;
}

@end
