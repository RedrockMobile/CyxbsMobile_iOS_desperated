//
//  NecessityViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Model;

NS_ASSUME_NONNULL_BEGIN

@interface NecessityViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *bkg;
@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIButton *btn2;
@property (nonatomic, strong)UIButton *btn3;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UILabel *detailLabel;
@property (nonatomic, weak) UIView *separatorView;
@property (assign, nonatomic)BOOL hidden;
@property (assign, nonatomic)BOOL isSelected;

typedef void(^ShowTextBlock)(NecessityViewCell *Cell);

@property (nonatomic, strong) Model *WMTModel;
@property (nonatomic, copy) ShowTextBlock showTextBlock;

+ (CGFloat) cellDefautHeight:(Model *)WMTModel;
+ (CGFloat) cellMoreHeight:(Model *)WMTModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexpath:(NSIndexPath *)indexPath;



@end

NS_ASSUME_NONNULL_END
