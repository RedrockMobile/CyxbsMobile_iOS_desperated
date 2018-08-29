//
//  SYCDataAnaylseViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "BaseViewController.h"
#import "SYCCollageModel.h"
#import "SYCSegmentView.h"

@interface SYCDataAnaylseViewController : BaseViewController <SYCSegmentViewDelegate>

@property (nonatomic, strong) SYCCollageModel *data;

@end
