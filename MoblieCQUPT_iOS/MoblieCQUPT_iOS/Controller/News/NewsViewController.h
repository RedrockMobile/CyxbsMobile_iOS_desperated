//
//  ViewController.h
//  重邮小帮手
//
//  Created by 1808 on 15/8/19.
//  Copyright (c) 2015年 1808. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic)UIRefreshControl *refresh;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (strong,nonatomic)NSMutableDictionary *data2;

@end

