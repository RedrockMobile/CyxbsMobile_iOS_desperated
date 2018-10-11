//
//  ShowPicRootView.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPicRootView : UIView
@property (strong, nonatomic) IBOutlet UIScrollView *picScrollView;


-(void)addScrollView:(NSArray *)data;
+(ShowPicRootView *)instancePicView;
@end
