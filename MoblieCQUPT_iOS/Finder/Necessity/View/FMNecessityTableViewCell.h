//
//  FMNecessityTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLNecessityModel;

@interface FMNecessityTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *bkg;
@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIButton *btn2;
@property (nonatomic, strong)UIButton *btn3;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UILabel *detailLabel;
@property (nonatomic, weak) UIView *separatorView;
@property (assign, nonatomic)BOOL hidden;
@property (assign, nonatomic)BOOL isSelected;

typedef void(^ShowTextBlock)(FMNecessityTableViewCell *Cell);

@property (nonatomic, strong) DLNecessityModel *DLNModel;
@property (nonatomic, copy) ShowTextBlock showTextBlock;


+ (CGFloat) cellDefautHeight:(DLNecessityModel *)DLNModel;
+ (CGFloat) cellMoreHeight:(DLNecessityModel *)DLNModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
