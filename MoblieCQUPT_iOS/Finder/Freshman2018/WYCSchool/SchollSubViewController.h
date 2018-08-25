//
//  SchollSubViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/17.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchollSubViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
-(void)setUrl:(NSString *)url;

@end
