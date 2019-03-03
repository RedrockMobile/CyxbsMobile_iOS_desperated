//
//  ExamPickView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/6.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamPickView : UIView
@property (strong, nonatomic) NSArray *nameArray;
@property (strong, nonatomic) NSString *title;
- (void)show;
@end
