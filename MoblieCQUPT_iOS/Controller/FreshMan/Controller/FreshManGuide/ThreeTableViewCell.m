//
//  ThreeTableViewCell.m
//  FreshMan
//
//  Created by dating on 16/8/12.
//  Copyright © 2016年 dating. All rights reserved.
//

#import "ThreeTableViewCell.h"

@implementation ThreeTableViewCell
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]init];
    self.Introduce.textColor =RGB(136, 136, 136);
    [gesture addTarget:self action:@selector(longpress)];
    [self addGestureRecognizer:gesture];
    
    // Initialization code
}


-(void)longpress{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
