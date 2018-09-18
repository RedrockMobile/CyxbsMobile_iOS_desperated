//
//  SYCOrganizationTableViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCOrganizationModel.h"

@interface SYCOrganizationTableViewController : UITableViewController

@property NSUInteger index;
@property (nonatomic, strong)SYCOrganizationModel *organization;

@end
