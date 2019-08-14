//
//  ReportTextView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myUILabel.h"

typedef NS_ENUM(NSInteger, wordNumState) {
    NoneWordNum = 0,
    OnlyWordNum,
    CountWordNum,
};


/**
 实现可计算文字多少的文本输入框
 */
@interface ReportTextView : UITextView

//显示文字字数的标签
@property (strong, nonatomic) UILabel *wordNum;
@property (strong, nonatomic) myUILabel *placeHolder;
@property (assign, nonatomic) NSInteger limitNum;

- (UITextView *)initWithFrame:(CGRect)frame andState:(wordNumState)state;
- (void)addTopic:(NSString *)topic;

@end
