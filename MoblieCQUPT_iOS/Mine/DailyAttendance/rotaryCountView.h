//
//  rotaryCountView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/19.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rotaryCountView : UIScrollView
- (id)initWithFrame:(CGRect)frame andNum:(NSString *)num;
- (void)selectNum:(NSString *)num;
@end
