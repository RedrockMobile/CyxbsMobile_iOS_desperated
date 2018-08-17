//
//  SYCShortTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/17.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCOrganizationModel.h"

@interface SYCShortTableViewCell : UITableViewCell

@property (nonatomic, strong)SYCOrganizationModel *organization;

@property (nonatomic)NSUInteger index;

@end
