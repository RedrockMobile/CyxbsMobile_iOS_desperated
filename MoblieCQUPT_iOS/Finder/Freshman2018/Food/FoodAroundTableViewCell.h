//
//  FoodAroundTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 陈大炮 on 2018/8/26.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodAroundModel;
@class autoScrollView;

@protocol clickDelegate <NSObject>
- (void)clickAtIndex:(NSIndexPath *)indexPath andscriollViewIndex:(NSInteger)index;
@end

@interface FoodAroundTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIImageView *bkgImg;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *ContentLabel;
@property (nonatomic, weak) UIView *separatorView;
@property (nonatomic, strong)FoodAroundModel *Model;
@property (nonatomic, strong)autoScrollView *imgViews;
@property (nonatomic, strong)NSIndexPath *Index;
@property (nonatomic, assign)NSInteger ScrollIndex;
@property (nonatomic, weak)id<clickDelegate>delegate;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UIButton *rankButton;

+ (CGFloat) cellHeight:(FoodAroundModel *)Model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
