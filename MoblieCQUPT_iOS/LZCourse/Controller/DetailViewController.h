//
//  DetailViewController.h
//  Demo
//
//  Created by 李展 on 2016/11/30.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonBtnModel.h"
@interface DetailViewController : UIViewController
- (instancetype)initWithMatters:(LessonBtnModel *)matters week:(NSInteger)week time:(NSInteger)time;
- (void)reloadMatters:(LessonBtnModel *)matters;
@property NSInteger time;
@end
