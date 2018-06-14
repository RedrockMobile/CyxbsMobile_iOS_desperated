//
//  YouWenAddViewController.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportTextView.h"

@interface YouWenAddViewController : BaseViewController
@property (strong, nonatomic) NSString *titleStr;
@property (strong, nonatomic) NSString *detailStr;
-(instancetype)initWithStyle:(NSString *)style;
@end
