//
//  SYCAddReminderViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/8/21.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ViewController.h"
#import "SYCNecessityViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SYCAddReminderViewControllerDelegate <NSObject>

- (void)reloadWithData:(NSMutableArray *)dataArray title:(NSMutableArray *)titleArray;

@end

@interface SYCAddReminderViewController : BaseViewController

@property (nonatomic) id<SYCAddReminderViewControllerDelegate> delegate;

@end



NS_ASSUME_NONNULL_END
