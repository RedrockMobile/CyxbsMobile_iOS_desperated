//
//  ListTableViewCell.h
//  选课名单
//
//  Created by 丁磊 on 2018/9/19.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ListModel;

@interface ListTableViewCell : UITableViewCell
@property(strong, nonatomic) UIImageView *bkg;
@property(strong, nonatomic) UILabel *nameLab;
@property(strong, nonatomic) UILabel *stuNumLab;
@property(strong, nonatomic) UILabel *majorLab;
@property(strong, nonatomic) UILabel *schoolLab;
@property(strong, nonatomic) UILabel *stuSecLab;
@property(strong, nonatomic) UILabel *classIdLab;
@property(strong, nonatomic) UILabel *year;
@property(strong, nonatomic) UILabel *lab1;
@property(strong, nonatomic) UILabel *lab2;
@property(strong, nonatomic) UILabel *lab3;
@property(strong, nonatomic) UILabel *lab4;
@property(strong, nonatomic) UIButton *MoreBtn;
@property(strong, nonatomic) ListModel *Model;

typedef void(^ShowTextBlock)(ListTableViewCell *Cell);

@property (nonatomic, copy) ShowTextBlock showTextBlock;

+ (CGFloat)cellDefautHeight;
+ (CGFloat)cellMoreHeight;

+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexpath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
