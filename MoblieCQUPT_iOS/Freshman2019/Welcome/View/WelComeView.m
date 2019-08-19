//
//  WelComeView.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/7.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "WelComeView.h"

@interface WelComeView ()

@property (nonatomic, weak) UIImageView *leftUp;
@property (nonatomic, weak) UIImageView *leftDown;
@property (nonatomic, weak) UIImageView *rightUp;
@property (nonatomic, weak) UIImageView *rightDown;
@property (nonatomic, weak) UIImageView *background_Before;
@property (nonatomic, weak) UIView *background_After;

// 四边的连接线
@property (nonatomic, weak) UIView *left;
@property (nonatomic, weak) UIView *right;
@property (nonatomic, weak) UIView *up;
@property (nonatomic, weak) UIView *down;

// 文字
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *body;
@property (nonatomic, weak) UILabel *author;

@end

@implementation WelComeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:213/255.0 green:233/255.0 blue:255/255.0 alpha:1];
        
        UIImageView *background_Before = [[UIImageView alloc] init];
        background_Before.image = [UIImage imageNamed:@"展开之前"];
        [self addSubview:background_Before];
        self.background_Before = background_Before;
        
        UIColor *linkColor = [UIColor colorWithRed:173/255.0 green:179/255.0 blue:254/255.0 alpha:1];
        UIColor *borderColor = [UIColor colorWithRed:82/255.0 green:105/255.0 blue:254/255.0 alpha:1];
        
        UIView *left = [[UIView alloc] init];
        left.backgroundColor = linkColor;
        left.layer.borderWidth = 1;
        left.layer.borderColor = borderColor.CGColor;
        [self addSubview:left];
        self.left = left;
        
        UIView *right = [[UIView alloc] init];
        right.backgroundColor = linkColor;
        right.layer.borderWidth = 1;
        right.layer.borderColor = borderColor.CGColor;
        [self addSubview:right];
        self.right = right;
        
        UIView *up = [[UIView alloc] init];
        up.backgroundColor = linkColor;
        up.layer.borderWidth = 1;
        up.layer.borderColor = borderColor.CGColor;
        [self addSubview:up];
        self.up = up;
        
        UIView *down = [[UIView alloc] init];
        down.backgroundColor = linkColor;
        down.layer.borderWidth = 1;
        down.layer.borderColor = borderColor.CGColor;
        [self addSubview:down];
        self.down = down;
        
        UIImageView *leftUP = [[UIImageView alloc] init];
        leftUP.image = [UIImage imageNamed:@"左上"];
        [self addSubview:leftUP];
        self.leftUp = leftUP;
        
        UIImageView *leftDown = [[UIImageView alloc] init];
        leftDown.image = [UIImage imageNamed:@"左下"];
        [self addSubview:leftDown];
        self.leftDown = leftDown;
        
        UIImageView *rightUp = [[UIImageView alloc] init];
        rightUp.image = [UIImage imageNamed:@"右上"];
        [self addSubview:rightUp];
        self.rightUp = rightUp;
        
        UIImageView *rightDown = [[UIImageView alloc] init];
        rightDown.image = [UIImage imageNamed:@"右下"];
        [self addSubview:rightDown];
        self.rightDown = rightDown;
        
        
        if (MAIN_SCREEN_H / MAIN_SCREEN_W == 667 / 375.0) {
            self.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H - 49 - 54);
            
            CGFloat self_W = self.frame.size.width;
            CGFloat self_H = self.frame.size.height;
            self.leftUp.frame = CGRectMake(self_W * 0.314, self_H * 0.4565, self_W * 0.3, self_W * 1.648 * 0.0465);
            self.rightDown.frame = CGRectMake(self_W * 0.384, self_H * 0.49, self_W * 0.3, self_W * 1.648 * 0.045);
            self.rightUp.frame = CGRectMake(self_W * 0.6493, self_H * 0.4565, self_W * 0.035, self_W * 1.648 * 0.0265);
            self.leftDown.frame = CGRectMake(self_W * 0.314, self_H * 0.51, self_W * 0.035, self_W * 1.648 * 0.025);
        } else if (MAIN_SCREEN_H / MAIN_SCREEN_W == 568/320.0) {
            self.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H - 49 - 54);
            
            CGFloat self_W = self.frame.size.width;
            CGFloat self_H = self.frame.size.height;
            self.leftUp.frame = CGRectMake(self_W * 0.314, self_H * 0.4565, self_W * 0.3, self_W * 1.648 * 0.0465);
            self.rightDown.frame = CGRectMake(self_W * 0.384, self_H * 0.49, self_W * 0.3, self_W * 1.648 * 0.045);
            self.rightUp.frame = CGRectMake(self_W * 0.6493, self_H * 0.4565, self_W * 0.035, self_W * 1.648 * 0.0265);
            self.leftDown.frame = CGRectMake(self_W * 0.314, self_H * 0.51, self_W * 0.035, self_W * 1.648 * 0.025);
        } else {
            self.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H - 49 - 120);
            
            CGFloat self_W = self.frame.size.width;
            CGFloat self_H = self.frame.size.height;
            self.leftUp.frame = CGRectMake(self_W * 0.314, self_H * 0.4565, self_W * 0.3, self_W * 1.648 * 0.0465);
            self.rightDown.frame = CGRectMake(self_W * 0.384, self_H * 0.485, self_W * 0.3, self_W * 1.648 * 0.045);
            self.rightUp.frame = CGRectMake(self_W * 0.6493, self_H * 0.4565, self_W * 0.035, self_W * 1.648 * 0.0265);
            self.leftDown.frame = CGRectMake(self_W * 0.314, self_H * 0.501, self_W * 0.035, self_W * 1.648 * 0.025);
        }
        
        CGFloat self_W = self.frame.size.width;
        CGFloat self_H = self.frame.size.height;
        self.background_Before.frame = CGRectMake(self_W * 0.3315, self_H * 0.465, self_W * 0.3323, self_W * 1.648 * 0.06);
        CGFloat background_X = self.background_Before.frame.origin.x;
        CGFloat background_Y = self.background_Before.frame.origin.y;
        CGFloat background_W = self.background_Before.frame.size.width;
        CGFloat background_H = self.background_Before.frame.size.height;
        
        self.left.frame = CGRectMake(background_X - 5, self.leftUp.frame.origin.y + self.leftUp.frame.size.height - 1, self_W * 0.008, self_W * 1.648 * 0.02);
        self.right.frame = CGRectMake(background_X + background_W + 2, self.rightUp.frame.origin.y + self.rightUp.frame.size.height - 1, self_W * 0.008, self_W * 1.648 * 0.02);
        self.up.frame = CGRectMake(self.leftUp.frame.origin.x + self.leftUp.frame.size.width , background_Y - 3, self_W * 0.04, self_W * 1.648 * 0.005);
        self.down.frame = CGRectMake(self.leftDown.frame.origin.x + self.leftDown.frame.size.width , background_Y + background_H, self_W * 0.04, self_W * 1.648 * 0.005);
        
    }
    return self;
}

- (void)spreadOutView {
    CGFloat self_W = self.frame.size.width;
    CGFloat self_H = self.frame.size.height;
    
    UIView *background_After = [[UIView alloc] initWithFrame:CGRectMake(self.background_Before.mj_x - 2, self.background_Before.mj_y - 2, self.background_Before.frame.size.width + 4, self.background_Before.frame.size.height + 4)];
    background_After.backgroundColor = [UIColor colorWithRed:244/255.0 green:248/255.0 blue:254/255.0 alpha:0.9];
    [self addSubview:background_After];
    [self sendSubviewToBack:background_After];
    self.background_After = background_After;
    
    self.background_Before.alpha = 0;
    
    UILabel *body = [[UILabel alloc] init];
    NSString *bodyText = @"  恭喜你经过了高考的考验，与重邮结识。成为邮子的你，想必一定对这所位于巍巍南山上的它倍感兴趣，在这里，我们将领你走入重邮，助你成功走上进入大学的第一步，帮助你解决从入学前到入学后的一系列可能遇到的问题。这里不仅有你感兴趣的校园宿舍食堂，还有助你入学的入学流程。更多的功能内容等你的探寻。在追寻梦想与踏上人生新征程的同时，希望有我们的同行与帮助，各位萌新能够更快的适应这全新的生活。希望充满好奇心的你能够在大学找到自己的舞台，发挥更好的自己，努力学习，钻研学术，广交好友。探索更多重邮内容请关注“2019迎新网”，更多迎新活动请关注微信公众号“重邮小帮手”。\n  期待与你的相遇。";
    body.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    body.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
    body.alpha = 0;
    body.numberOfLines = 0;
    [background_After addSubview:body];
    self.body = body;
    
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.firstLineHeadIndent = 20.0;
    //行间距
    if (MAIN_SCREEN_H / MAIN_SCREEN_W == 667/375.0) {
        paraStyle.lineSpacing = 8.0;
    } else if (MAIN_SCREEN_H / MAIN_SCREEN_W == 568/320.0) {
        paraStyle.lineSpacing = 6.0;
        body.font = [UIFont systemFontOfSize:11 weight:UIFontWeightThin];
    } else {
        paraStyle.lineSpacing = 10.0;
    }
    textDict[NSParagraphStyleAttributeName] = paraStyle;
    body.attributedText = [[NSAttributedString alloc] initWithString:bodyText attributes:textDict];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"亲爱的你：";
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    title.alpha = 0;
    title.numberOfLines = 0;
    [background_After addSubview:title];
    self.title = title;
    
    UILabel *author = [[UILabel alloc] init];
    author.text = @"红岩网校工作站";
    author.font = [UIFont systemFontOfSize:13];
    author.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    author.alpha = 0;
    author.numberOfLines = 0;
    [background_After addSubview:author];
    self.author = author;
    
    if (MAIN_SCREEN_H / MAIN_SCREEN_W == 568/320.0) {
        title.font = [UIFont systemFontOfSize:12];
        author.font = [UIFont systemFontOfSize:12];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(background_After).offset(33);
            make.top.equalTo(background_After).offset(27);
        }];
        [body mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.right.equalTo(background_After).offset(-33);
            make.top.equalTo(title.mas_bottom).offset(5);
        }];
        [author mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(body.mas_bottom).offset(5);
            make.right.equalTo(body);
        }];
    } else {
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(background_After).offset(33);
            make.top.equalTo(background_After).offset(40);
        }];
        [body mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.right.equalTo(background_After).offset(-33);
            make.top.equalTo(title.mas_bottom).offset(10);
        }];
        [author mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(body.mas_bottom).offset(10);
            make.right.equalTo(body);
        }];
    }
    
    
    [UIView animateWithDuration:1.5 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];

        // 四个角
        if (MAIN_SCREEN_H / MAIN_SCREEN_W == 667 / 375.0) {
            self.leftUp.frame = CGRectMake(self_W * 0.04, self_H * 0.027, self_W * 0.3, self_W * 1.648 * 0.0465);
            self.rightDown.frame = CGRectMake(self_W * 0.66, self_H * 0.915, self_W * 0.3, self_W * 1.648 * 0.045);
            self.rightUp.frame = CGRectMake(self_W * 0.925, self_H * 0.027, self_W * 0.035, self_W * 1.648 * 0.0265);
            self.leftDown.frame = CGRectMake(self_W * 0.04, self_H * 0.935 , self_W * 0.035, self_W * 1.648 * 0.025);
        } else {
            self.leftUp.frame = CGRectMake(self_W * 0.04, self_H * 0.03, self_W * 0.3, self_W * 1.648 * 0.0465);
            self.rightDown.frame = CGRectMake(self_W * 0.66, self_H * 0.921, self_W * 0.3, self_W * 1.648 * 0.045);
            self.rightUp.frame = CGRectMake(self_W * 0.925, self_H * 0.03, self_W * 0.035, self_W * 1.648 * 0.0265);
            self.leftDown.frame = CGRectMake(self_W * 0.04, self_H * 0.937 , self_W * 0.035, self_W * 1.648 * 0.025);
        }

        // 连接线
        self.left.frame = CGRectMake(self_W * 0.048, self.leftUp.frame.origin.y + self.leftUp.frame.size.height, self_W * 0.008, self_H * 0.87);
        self.right.frame = CGRectMake(self_W * 0.945, self.rightUp.frame.origin.y + self.rightUp.frame.size.height, self_W * 0.008, self_H * 0.87);
        self.up.frame = CGRectMake(self_W * 0.32, self_H * 0.032, self.frame.size.width * 0.64, self_W * 0.008);
        self.down.frame = CGRectMake(self_W * 0.07, self_H * 0.952, self.frame.size.width * 0.64, self_W * 0.008);

        // 背景
        background_After.frame = CGRectMake(self.left.mj_x + 2, self.up.mj_y + 2, self.right.mj_x - self.left.mj_x - 2, self.down.mj_y - self.up.mj_y - 2);
        
        [self performSelector:@selector(showText) withObject:nil afterDelay:1.5];
    }];
}

- (void)showText {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"我知道啦"] forState:UIControlStateNormal];
    [button setTitle:@"我知道啦" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.frame = CGRectMake(self.background_After.width * 0.33, self.background_After.height * 0.88, self.background_After.width * 0.33, self.background_After.height * 0.07);
    
    [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.background_After addSubview:button];
    button.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        button.alpha = 1;
        self.author.alpha = 1;
        self.body.alpha = 1;
        self.title.alpha = 1;
    }];
}

- (void)dismissSelf {
    [self removeFromSuperview];
}

@end
