//
//  MilitarytrainingTipsViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreshmanModel.h"

@interface MilitarytrainingTipsViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *contentview;

@property (nonatomic, strong) FreshmanModel *tipsModel;
@end
