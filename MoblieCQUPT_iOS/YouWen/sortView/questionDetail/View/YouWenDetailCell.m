//
//  YouWenDetailCell.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/15.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenDetailCell.h"
#import <SDWebImageManager.h>

@implementation YouWenDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        if ([reuseIdentifier isEqualToString:@"YouWenDetailCellFirst"]) {
            self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
        } else {
            self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] lastObject];
        }
        [self.adoptBtn.layer setBorderColor:[UIColor colorWithRed:150/255.0 green:157/255.0 blue:254/255.0 alpha:1].CGColor];
        [self.adoptBtn.layer setCornerRadius:10.0];
        self.genderImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.upvoteImageView.contentMode = UIViewContentModeScaleAspectFit;;
//        self.commentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
