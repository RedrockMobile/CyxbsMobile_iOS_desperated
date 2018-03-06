//
//  FinderCollectionViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "FinderCollectionViewCell.h"

@implementation FinderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentImageView.layer.cornerRadius = 5;
    self.contentImageView.layer.masksToBounds = YES;
    // Initialization code
}

@end
