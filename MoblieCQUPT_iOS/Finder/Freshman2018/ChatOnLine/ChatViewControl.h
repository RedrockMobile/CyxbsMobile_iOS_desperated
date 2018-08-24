//
//  ViewControl.h
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//
typedef void(^callBack)(void);

#import <UIKit/UIKit.h>
#import "SegmentView.h"


@interface ChatViewControl : UIViewController
//@property (retain,nonatomic)UISegmentedControl *segmentedControl;
@property (nonatomic,strong)SegmentView *MainSegmentView;

@property (nonatomic, strong)callBack callBackHandle;

@end
