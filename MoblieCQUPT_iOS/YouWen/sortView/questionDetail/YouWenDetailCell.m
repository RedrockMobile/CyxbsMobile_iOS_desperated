//
//  YouWenDetailCell.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenDetailCell.h"

@implementation YouWenDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
        self.genderImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.upvoteImageView.contentMode = UIViewContentModeScaleAspectFit;;
        self.commentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
