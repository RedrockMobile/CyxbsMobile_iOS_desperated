//
//  ViewController.h
//  EmptyRoomsTest
//
//  Created by RainyTunes on 8/23/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBSConsultDataBundle.h"
#import "BFPaperCheckbox.h"

@interface XBSEmptyRoomViewController : UIViewController<BFPaperCheckboxDelegate>
@property (strong,nonatomic)XBSConsultDataBundle *delegate;
@property (strong,nonatomic)NSMutableArray *buildCheckboxGroup, *periodCheckboxGroup;
@property (assign,nonatomic)BOOL isChanging;
@property (assign,nonatomic)BOOL lock;
- (NSString *)refreshResult;
@end

