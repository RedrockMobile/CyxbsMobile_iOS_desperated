//
//  XBSSchduleViewController.h
//  ConsultingTest
//
//  Created by RainyTunes on 8/21/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "We.h"
#import "MainViewController.h"
#import "XBSConsultDataBundle.h"
#import "XBSViewController.h"

@interface XBSSchduleViewController : XBSViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic)XBSConsultDataBundle *delegate;
@end
