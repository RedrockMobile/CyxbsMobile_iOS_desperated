//
//  FirstViewController.h
//  重邮小帮手
//
//  Created by 1808 on 15/8/20.
//  Copyright (c) 2015年 1808. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *top1label;
@property (strong ,nonatomic)NSMutableDictionary *data1;
@property (weak, nonatomic) IBOutlet UILabel *day1label;
@property (strong, nonatomic) NSMutableDictionary *info;//记录page、size、type、aritcleid参数

@end
