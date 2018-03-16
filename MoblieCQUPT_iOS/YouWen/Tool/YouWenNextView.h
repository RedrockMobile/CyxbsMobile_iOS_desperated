//
//  YouWenTimeView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/10.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransparentView.h"
@protocol getInformation <NSObject>
@optional
- (void)sendInformation:(NSString *)inf;
@end
@interface YouWenNextView : TransparentView
@property (nonatomic, weak) id <getInformation> delegate;
@property (nonatomic, strong) NSMutableString *inf;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIButton *confirBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
- (void)addDetail;
- (void)confirm;
- (void)quit;
@end
