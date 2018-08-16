//
//  DeliveryTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeliveryModel;


@protocol clickDelegate <NSObject>
- (void)clickAtIndex:(NSIndexPath *)indexPath;

@end


@interface DeliveryTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *image;
@property (nonatomic, strong)UIImageView *bkgImage;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *contentLab;

@property (nonatomic, strong)DeliveryModel *Model;

@property(nonatomic,strong)NSIndexPath *Index;
@property(nonatomic,weak)id<clickDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight:(DeliveryModel *)Model;

@end
