//
//  BusTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BusModel;
@class autoScrollView;

@protocol clickDelegate <NSObject>
- (void)clickAtIndex:(NSIndexPath *)indexPath andscriollViewIndex:(NSInteger)index;

@end

@interface BusTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIImageView *bkgImg;
@property (nonatomic, strong)UIImageView *sdwImg;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *ContentLabel;
@property (nonatomic, weak) UIView *separatorView;
@property (nonatomic, strong)BusModel *Model;
@property (nonatomic, strong)autoScrollView *imgViews;
@property (nonatomic, strong)NSIndexPath *Index;
@property (nonatomic, assign)NSInteger ScrollIndex;
@property (nonatomic, weak)id<clickDelegate>delegate;

+ (CGFloat) cellHeight:(BusModel *)Model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

