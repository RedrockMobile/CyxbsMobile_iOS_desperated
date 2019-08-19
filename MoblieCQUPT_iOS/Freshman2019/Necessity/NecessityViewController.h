//
//  NecessityViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^callBack)(void);
NS_ASSUME_NONNULL_BEGIN

@interface NecessityViewController : BaseViewController
@property (nonatomic, strong)callBack callBackHandle;

@end

NS_ASSUME_NONNULL_END
