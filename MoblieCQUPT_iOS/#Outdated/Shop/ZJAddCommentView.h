//
//  ZJAddCommentView.h
//  MoblieCQUPT_iOS
//
//  Created by 周杰 on 2017/11/25.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJAddCommentView : UIView
@property (weak, nonatomic) UITableView *addCommentsTableView;
@property (strong, nonatomic) UIView *addCommentsView;
@property (nonatomic, copy) void(^AddCommentBlock)(NSString *str);
@property (nonatomic,copy)void(^markBlock)(int markView);
@property (assign,nonatomic)int mark;//标记底部页面是否弹出

-(void)showInView:(UIView* )view;
@end
