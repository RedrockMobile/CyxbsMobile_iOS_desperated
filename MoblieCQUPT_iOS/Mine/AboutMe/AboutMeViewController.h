//
//  AboutMeViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 16/3/31.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeViewController : BaseViewController
//type 为1 请求的是 点赞 type为2 请求的是评论 3为全部
- (instancetype)initViewType:(NSString *)type;
@property (strong, nonatomic) UIViewController *superController;
@end
