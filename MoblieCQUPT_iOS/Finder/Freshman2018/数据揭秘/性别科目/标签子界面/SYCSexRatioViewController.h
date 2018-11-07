//
//  SYCSexRatioViewController.h
//  CQUPTDataAnalyse
//
//  Created by 施昱丞 on 2018/8/9.
//  Copyright © 2018年 shiyucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCCollageModel.h"

@interface SYCSexRatioViewController : BaseViewController

@property (nonatomic, strong) NSString *collage;

@property (nonatomic, strong) SYCCollageModel *data;

-(void)reflesh;

@end
