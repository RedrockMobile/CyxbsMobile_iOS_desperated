//
//  DLNecessityViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^callBack)(void);

@interface DLNecessityViewController : BaseViewController

@property (nonatomic, strong)callBack callBackHandle;

@end
