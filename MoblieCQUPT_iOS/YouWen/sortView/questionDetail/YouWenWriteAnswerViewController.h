//
//  YouWenWriteAnswerViewController.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/7.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

//刷新父VC，弹出提示框
@protocol YouWenWriteAnswerDelegate <NSObject>
- (void)reload;
@end

@interface YouWenWriteAnswerViewController : UIViewController

@property (copy, nonatomic) NSString *question_id;
@property (nonatomic, strong) id <YouWenWriteAnswerDelegate> delegate;
@end
