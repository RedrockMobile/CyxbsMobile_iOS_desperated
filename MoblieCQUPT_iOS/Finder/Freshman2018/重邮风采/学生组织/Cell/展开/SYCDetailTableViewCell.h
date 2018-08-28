//
//  SYCDetailTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/20.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCOrganizationManager.h"
#import "SYCOrganizationModel.h"

@interface SYCDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)SYCOrganizationModel *organization;
@property (nonatomic)Boolean isShowed;

@end
