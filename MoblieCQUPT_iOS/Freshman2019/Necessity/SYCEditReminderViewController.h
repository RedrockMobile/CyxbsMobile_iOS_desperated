//
//  SYCEditReminderViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/8/23.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ViewController.h"
#import "Model/DLNecessityModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SYCEditReminderViewControllerDelagate <NSObject>

- (void)reloadDataWithReminder:(NSMutableArray *)reminders;

@end

@interface SYCEditReminderViewController : BaseViewController

@property (nonatomic) NSMutableArray<DLNecessityModel *> *reminders;
@property (nonatomic) id<SYCEditReminderViewControllerDelagate> delagete;

@end

NS_ASSUME_NONNULL_END
