//
//  MyMessagesTableViewCell.m
//  Photo
//
//  Created by GQuEen on 16/5/10.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#define kFont [UIFont fontWithName:@"Arial" size:15]
#define kTextColor [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1]
#define kDetailTextColor [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:0.7]

#import "MyMessagesTableViewCell.h"

@implementation MyMessagesTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"myMessagesTableViewCell";
    MyMessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[MyMessagesTableViewCell alloc] initWithReuseIdentifier:identify];
    }
    return cell;
}

- (instancetype) initWithReuseIdentifier:(NSString *)identify {
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify]){
        [self loadContentView];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)loadContentView {
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 50, 50)];
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = _avatar.frame.size.width/2;
    
    [self.contentView addSubview:_avatar];
    
    _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, MAIN_SCREEN_W-80-25, 15)];
    _nicknameLabel.font = kFont;
    _nicknameLabel.textColor = kTextColor;
    
    [self.contentView addSubview:_nicknameLabel];
    
    _introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, MAIN_SCREEN_W-80-25, 15)];
    _introductionLabel.font = kFont;
    _introductionLabel.textColor = kDetailTextColor;
    
    [self.contentView addSubview:_introductionLabel];
}

@end
