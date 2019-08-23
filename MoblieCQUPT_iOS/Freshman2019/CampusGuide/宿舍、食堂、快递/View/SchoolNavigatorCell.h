//
//  SchoolNavigatorCell.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/17.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressSpotItem.h"
#import "DiningHallAndDormitoryItem.h"
#import <SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface SchoolNavigatorCell : UITableViewCell

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIImageView *photoView;
@property (nonatomic, weak) UIImageView *backgroundImageView;

// 快递
@property (nonatomic, strong) ExpressSpotItem *spotModel;

// 食堂，宿舍
@property (nonatomic, strong)  DiningHallAndDormitoryItem *diningHallAndDormitoryModel;
@property (nonatomic, copy) NSArray<NSString *> *rollImageURL; // 宿舍，食堂轮播图url
@property (nonatomic, weak) SDCycleScrollView *scrollImage;

@end

NS_ASSUME_NONNULL_END
