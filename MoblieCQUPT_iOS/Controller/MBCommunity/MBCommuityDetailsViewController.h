//
//  MBCommuityDetailsViewController.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/21.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCommunity_ViewModel.h"
#import "MBComment_ViewModel.h"

@interface MBCommuityDetailsViewController : UIViewController

@property (strong, nonatomic) MBCommunity_ViewModel *viewModel;
@property (strong, nonatomic) MBComment_ViewModel *commentViewModel;

@end
