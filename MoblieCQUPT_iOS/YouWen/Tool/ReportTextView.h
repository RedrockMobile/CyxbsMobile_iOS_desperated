//
//  ReportTextView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myUILabel.h"

@interface ReportTextView : UITextView

typedef NS_ENUM(NSInteger, wordNumState) {
    NoneWordNum = 0,
    OnlyWordNum,
    CountWordNum,
};
@property (strong, nonatomic) UILabel *wordNum;
@property (strong, nonatomic) myUILabel *placeHolder;
@property (assign, nonatomic) NSInteger limitNum;
- (UITextView *)initWithFrame:(CGRect)frame andState:(wordNumState)state;
- (void)addTopic:(NSString *)topic;

@end
