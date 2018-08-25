//
//  MilitarytrainingShowViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreshmanModel.h"

@interface MilitarytrainingShowViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *videoview;
@property (strong, nonatomic) IBOutlet UIView *picview;
@property(nonatomic, strong)FreshmanModel *showModel;


@end
