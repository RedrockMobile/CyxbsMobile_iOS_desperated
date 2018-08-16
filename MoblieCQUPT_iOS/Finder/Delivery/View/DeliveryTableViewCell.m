//
//  DeliveryTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "DeliveryTableViewCell.h"
#import "DeliveryModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667


@implementation DeliveryTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier: reuseIdentifier]){
        self.bkgImage = [[UIImageView alloc]initWithFrame:CGRectMake(15*WIDTH, 15*HEIGHT, 346*WIDTH, 89*HEIGHT)];
        self.bkgImage.image = [UIImage imageNamed:@"白底"];
        [self.contentView addSubview:self.bkgImage];
        
        
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH, 30*HEIGHT, 102*WIDTH, 59*HEIGHT)];
        self.image.userInteractionEnabled = YES;
        self.image.layer.cornerRadius=10;
        self.image.clipsToBounds=YES;
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage)];
        [self.image addGestureRecognizer:tapGesture];
        
        [self.contentView addSubview:self.image];
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(147*WIDTH, 31*HEIGHT, 195*WIDTH, 14*HEIGHT)];
        self.titleLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLab];
        
        self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(146*WIDTH, 51*HEIGHT, 195*WIDTH, 32*HEIGHT)];
        self.contentLab.font = [UIFont systemFontOfSize:13];
        self.contentLab.numberOfLines = 2;
        [self.contentView addSubview:self.contentLab];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Identifier = @"status";
    DeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[DeliveryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (DeliveryTableViewCell *)cell;
}

- (void)setModel:(DeliveryModel *)Model{
    _Model = Model;
    self.titleLab.text = self.Model.title;
    self.image.image = self.Model.imgarr[0];
    self.contentLab.text = self.Model.content;
}


+ (CGFloat)cellHeight{
    return 89*HEIGHT;
}

- (void)didClickImage{
    [self.delegate clickAtIndex:_Index];
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
