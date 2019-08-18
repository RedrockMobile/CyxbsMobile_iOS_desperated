//
//  StartStepsCell.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "StartStepsCell.h"

@interface StartStepsCell ()

@end

@implementation StartStepsCell

- (void)setModel:(StepsModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.messageLabel.text = model.message;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:model.photo];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (!image) {
                self.extendedHeight = self.messageLabel.mj_y + self.messageLabel.height + 30;
            } else {
                UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(self.messageLabel.mj_x, self.messageLabel.mj_y + self.messageLabel.height + 10, self.messageLabel.width, image.size.height * (self.messageLabel.width / image.size.width) + 20)];
                photo.image = image;
                photo.contentMode = UIViewContentModeScaleAspectFit;
                photo.alpha = 0;
                [self.contentView addSubview:photo];
                self.photo = photo;

                self.extendedHeight = self.photo.origin.y + self.photo.frame.size.height + 20;
            }
        });
    });
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 0, 20, 0);
    self.backgroundImageView.image = [self.backgroundImageView.image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
}

- (void)extend {
    [UIView animateWithDuration:0.25 animations:^{
        self.extendButton.transform = CGAffineTransformMakeScale(1, -1);
        self.messageLabel.alpha = 1;
        self.photo.alpha = 1;
    }];
}

- (void)fold {
    [UIView animateWithDuration:0.25 animations:^{
        self.extendButton.transform = CGAffineTransformMakeScale(1, 1);
        self.messageLabel.alpha = 0;
        self.photo.alpha = 0;
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
