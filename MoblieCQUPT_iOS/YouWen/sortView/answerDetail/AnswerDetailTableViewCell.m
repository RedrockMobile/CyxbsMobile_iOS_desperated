//
//  AnswerDetailTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/5.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "AnswerDetailTableViewCell.h"

@implementation AnswerDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2.0;
    }
    
    return self;
}

@end
