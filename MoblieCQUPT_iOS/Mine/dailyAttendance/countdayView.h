//
//  countdayView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/5/19.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface countdayView : UIView
- (id)initWithFrame:(CGRect)frame AndDay:(NSString *)day;
- (void)selectDay:(NSString *)day;
@end
