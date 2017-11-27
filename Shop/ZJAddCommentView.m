//
//  ZJAddCommentView.m
//  MoblieCQUPT_iOS
//
//  Created by 周杰 on 2017/11/25.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "ZJAddCommentView.h"

#define UIHeight [UIScreen mainScreen].bounds.size.height
#define UIWidth  [UIScreen mainScreen].bounds.size.width
#define addCommentsViewHeight 300
@interface ZJAddCommentView()
@property(nonatomic, strong) UITextView *textView;
@property(copy, nonatomic) NSString *text;
@end
@implementation ZJAddCommentView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
//懒加载评论View
- (UIView *)addCommentsView{
    if (_addCommentsView == nil) {
        _addCommentsView = [[UIView alloc]initWithFrame:CGRectMake(0, UIHeight-addCommentsViewHeight, UIWidth, addCommentsViewHeight-50)];
        _addCommentsView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addCommentsView];
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(15, 15, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_addCommentsView addSubview:closeBtn];
        
        UIButton *send = [[UIButton alloc]initWithFrame:CGRectMake(_addCommentsView.frame.size.width-20-30, 15, 25, 25)];
        [send setTitle:@"发送" forState:UIControlStateNormal];
        [send setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        send.tintColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1.0];
        send.titleLabel.font = [UIFont systemFontOfSize:12];
        [send addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
        [_addCommentsView addSubview:send];
        
        UIView *line = [[UILabel alloc] init];
        line.frame = CGRectMake(0, 50 - 1, UIWidth, 1);
        line.backgroundColor = [UIColor colorWithRed:243/255 green:243/255 blue:243/255 alpha:1.0];
        [_addCommentsView addSubview:line];
        
        _textView= [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.frame = CGRectMake(0, 50, UIWidth, addCommentsViewHeight-50);
        
        [_addCommentsView addSubview:_textView];
        //注册观察键盘的变化
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        
        
    }
    return self;
}

- (void)loadData{
    _text = [_textView text];
    
    
    if (self.AddCommentBlock) {
        self.AddCommentBlock(_text);//_text为用户所写的评论
    }
    [self disMissView];
    
}
-(void)setUI{
//    self.frame = CGRectMake(0, 0, UIWidth, addCommentsViewHeight+68);
    //alpha 0.0  白色 alpha 1 黑色 0~1  遮罩逐渐
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissView)]];
    [self addCommentsView];
}
//弹出键盘
- (void)transformView:(NSNotification *)aNSNotification{
    //    获取键盘弹出前的rect
    NSValue *keyBoardBeginBounds = [[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [keyBoardBeginBounds CGRectValue];
    
    //    获取键盘弹出后的rect
    NSValue *keyVoardEndBounds = [[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [keyVoardEndBounds CGRectValue];
    
    //    获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY = endRect.origin.y-beginRect.origin.y;
    //    在0.25s内完成self.view的frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [_addCommentsView setFrame:CGRectMake(_addCommentsView.frame.origin.x, _addCommentsView.frame.origin.y+deltaY, _addCommentsView.frame.size.width,_addCommentsView.frame.size.height)];
    }];
}
//弹出评论的View
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_addCommentsView];
    self.frame = CGRectMake(0, 0, UIWidth,MAIN_SCREEN_H);
    //alpha 0.0  白色 alpha 1 黑色 0~1  遮罩逐渐
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    [_addCommentsView setFrame:CGRectMake(0, UIHeight, UIWidth, addCommentsViewHeight)];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_addCommentsView setFrame:CGRectMake(0, UIHeight - addCommentsViewHeight, UIWidth, addCommentsViewHeight)];
        
    } completion:nil];
    _mark = 0;//页面弹出_mark标记为0
    if (self.markBlock) {
        self.markBlock(_mark);
    }
}
//消去评论View

- (void)disMissView{
    [_addCommentsView setFrame:CGRectMake(0, UIHeight - addCommentsViewHeight, UIWidth, addCommentsViewHeight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [_addCommentsView setFrame:CGRectMake(0, UIHeight, UIWidth, addCommentsViewHeight)];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [_addCommentsView removeFromSuperview];
                         
                     }];
    _mark = 1;//页面移除_flag标记为1
    
    if (self.markBlock) {
        self.markBlock(_mark);
    }
    
}

@end
