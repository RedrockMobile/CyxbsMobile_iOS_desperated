//
//  AddRemindViewController.h
//  Demo
//
//  Created by 李展 on 2016/11/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRemindViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *titileTextView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithRemind:(NSDictionary *)remind;
@end
