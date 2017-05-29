//
//  GQUCell.h
//  GGTableViewCell
//
//  Created by GQuEen on 16/8/13.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGCellModel.h"

typedef NS_ENUM(NSInteger, GGShowCellTextType) {
    GGShowCellTextTypeNormal,
    GGShowCellTextTypeExpend,
};

@interface GQUCell : UITableViewCell

@property (strong, nonatomic) GGCellModel *model;

@property (copy, nonatomic) NSString *headTitle;

@property (assign, nonatomic) GGShowCellTextType cellType;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)clickCell;

@end
