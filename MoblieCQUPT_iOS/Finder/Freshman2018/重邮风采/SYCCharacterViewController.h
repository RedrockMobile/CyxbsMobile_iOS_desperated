//
//  SYCCharacterViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//
typedef void(^callBack)(void);

#import "BaseViewController.h"

@interface SYCCharacterViewController : BaseViewController

@property (nonatomic, strong)callBack callBackHandle;

@end
