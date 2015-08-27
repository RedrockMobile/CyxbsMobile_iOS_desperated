//
//  ViewController.h
//  EmptyRoomsTest
//
//  Created by RainyTunes on 8/23/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBundle.h"
#import "BFPaperCheckbox.h"

@interface EmptyRoomsViewController : UIViewController<BFPaperCheckboxDelegate>
@property (strong,nonatomic)DataBundle *delegate;
- (NSString *)refreshResult;
- (void)test;
@end

