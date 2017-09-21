//
//  LXDetailCommentView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/9/7.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LXDetailCommentView.h"

@implementation LXDetailCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.hidden = YES;
        
        UIToolbar *toolBarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 48/667.0 * SCREENHEIGHT)];
        toolBarView.backgroundColor = [UIColor whiteColor];
        [self addSubview:toolBarView];
        
        self.cancelBtn = [[UIButton alloc] init];
        [toolBarView addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolBarView.mas_top).offset(14);
            make.left.equalTo(toolBarView.mas_left).offset(24);
            make.width.mas_equalTo(@18);
            make.height.mas_equalTo(@18);
        }];
        self.backgroundColor = [UIColor whiteColor];
        [toolBarView addSubview:self.cancelBtn];
        [self.cancelBtn setImage:[UIImage imageNamed:@"灰色叉叉"] forState:UIControlStateNormal];
        
        _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(26, 48/667.0 * SCREENHEIGHT + 14, SCREENWIDTH - 26*2, 271/667.0 * SCREENHEIGHT - 47/667.0 * SCREENHEIGHT)];
        [self addSubview:_commentTextView];
        _commentTextView.font = [UIFont systemFontOfSize:13];
        
        self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(4, 8, SCREENWIDTH - 32, 15)];
        [_commentTextView addSubview:self.placeholder];
        self.placeholder.text = @"说点什么吧...";
        self.placeholder.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        
        self.sendBtn = [[UIButton alloc] init];
        [toolBarView addSubview:self.sendBtn];
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(toolBarView.mas_right).offset(-16);
            make.centerY.mas_equalTo(toolBarView.mas_centerY);
            make.width.mas_equalTo(@38);
            make.height.mas_equalTo(@22);
        }];
        [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [self.sendBtn setTitleColor:[UIColor colorWithRed:109/255.0 green:131/255.0 blue:238/255.0 alpha:1] forState:UIControlStateNormal];

    }
    
    return self;
}

@end
