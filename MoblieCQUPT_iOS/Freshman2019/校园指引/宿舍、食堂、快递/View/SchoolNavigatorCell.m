//
//  SchoolNavigatorCell.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/17.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SchoolNavigatorCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SchoolNavigatorCell

- (void)setSpotModel:(ExpressSpotItem *)spotModel {
    _spotModel = spotModel;
    self.titleLabel.text = spotModel.spotName;
    self.detailLabel.text = spotModel.detail;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

//    NSURL *imageURL = [NSURL URLWithString:spotModel.photo];
    SDCycleScrollView *scrollImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(33, 33, MAIN_SCREEN_W - 66, (MAIN_SCREEN_W - 66) * 0.618) imageNamesGroup:@[spotModel.photo]];
    [self.contentView addSubview:scrollImage];
}

- (void)setDiningHallAndDormitoryModel:(DiningHallAndDormitoryItem *)diningHallAndDormitoryModel {
    _diningHallAndDormitoryModel = diningHallAndDormitoryModel;
    self.titleLabel.text = diningHallAndDormitoryModel.name;
    self.detailLabel.text = diningHallAndDormitoryModel.detail;
    self.rollImageURL = diningHallAndDormitoryModel.rollImageURL;
    SDCycleScrollView *scrollImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(36, 36, MAIN_SCREEN_W - 72, (MAIN_SCREEN_W - 72) * 0.618) imageNamesGroup:self.rollImageURL];
    scrollImage.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:scrollImage];
    self.scrollImage = scrollImage;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *backgroundImageView = [[UIImageView alloc] init];
        UIImage *background = [UIImage imageNamed:@"校园指引背景"];
        [background resizableImageWithCapInsets:UIEdgeInsetsMake(50, 0, 50, 0) resizingMode:UIImageResizingModeStretch];
        backgroundImageView.image = background;
        [self.contentView addSubview:backgroundImageView];
        self.backgroundImageView = backgroundImageView;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.backgroundImageView addSubview:imageView];
        self.photoView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:14.0f];
        titleLabel.numberOfLines = 0;
        [self.backgroundImageView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.numberOfLines = 0;
        [self.backgroundImageView addSubview:detailLabel];
        self.detailLabel = detailLabel;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.spotModel) {
        self.scrollImage.frame = self.spotModel.ImageFrame;
        self.titleLabel.frame = self.spotModel.titleLabelFrame;
        self.detailLabel.frame = self.spotModel.detailLabelFrame;
        self.backgroundImageView.frame = self.spotModel.backgroundFrame;
    } else {
        self.scrollImage.frame = self.diningHallAndDormitoryModel.rollImageFrame;
        self.titleLabel.frame = self.diningHallAndDormitoryModel.titleLabelFrame;
        self.detailLabel.frame = self.diningHallAndDormitoryModel.detailLabelFrame;
        self.backgroundImageView.frame = self.diningHallAndDormitoryModel.backgroundFrame;
    }
}

@end
