//
//  SYCCollageTableViewController.h
//  CQUPTDataAnalyse
//
//  Created by 施昱丞 on 2018/8/10.
//  Copyright © 2018年 shiyucheng. All rights reserved.
//

typedef void(^callBack)(void);

#import <UIKit/UIKit.h>

@interface SYCCollageTableViewController : UITableViewController

@property (nonatomic, strong)callBack callBackHandle;


@end
