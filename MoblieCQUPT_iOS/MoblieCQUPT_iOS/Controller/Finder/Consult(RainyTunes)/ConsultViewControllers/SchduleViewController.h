//
//  SchduleViewController.h
//  ConsultingTest
//
//  Created by RainyTunes on 8/21/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "We.h"
#import "MainViewController.h"
#import "DataBundle.h"

@interface SchduleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic)DataBundle *delegate;
@end
