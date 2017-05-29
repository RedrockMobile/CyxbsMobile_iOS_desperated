//
//  TopicSearchViewController.h
//  TopicSearch
//
//  Created by hzl on 2017/5/21.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailTopicViewController;

@interface TopicSearchViewController : UIViewController

@property (nonatomic, assign) BOOL isMyJoin;

@property (nonatomic, strong) NSString *searchText;

@property (nonatomic, strong) void(^pushBlk)(DetailTopicViewController *);

- (void)searchDataRefresh;

@end
