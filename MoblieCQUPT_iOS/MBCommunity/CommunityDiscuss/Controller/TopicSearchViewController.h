//
//  TopicSearchViewController.h
//  TopicSearch
//
//  Created by hzl on 2017/5/21.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicSearchViewController : UIViewController

@property (nonatomic, assign) BOOL isMyJoin;

@property (nonatomic, strong) NSString *searchText;

//@property (nonatomic, strong) void(^pushBlk)(*这里填要传入的控制器*);

- (void)searchDataRefresh;

@end
