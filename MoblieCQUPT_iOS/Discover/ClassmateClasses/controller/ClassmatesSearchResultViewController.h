//
//  ClassmatesSearchResultViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassmatesList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassmatesSearchResultViewController : UITableViewController

- (instancetype)initWithClassmatesList:(ClassmatesList *)classmatesList;

@end

NS_ASSUME_NONNULL_END
