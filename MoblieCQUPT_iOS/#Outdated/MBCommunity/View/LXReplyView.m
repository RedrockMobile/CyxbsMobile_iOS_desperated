//
//  LXReplyView.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/9/6.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LXReplyView.h"

@interface LXReplyView ()

@property (strong, nonatomic)UIImageView *commentIconImageView;
@property (strong, nonatomic)UIImageView *commentTitleImageView;

@end


@implementation LXReplyView

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
        [self setUI];
    }
    
    return self;
}

- (void)setUI {    
    self.frame = CGRectMake(0, SCREEN_HEIGHT - 59, SCREEN_WIDTH, 59);
    
    CGRect commentBtnRect = CGRectMake(0, 0, SCREEN_WIDTH/2.0, 59);
    self.commentBtn = [[UIButton alloc] init];
    [self addSubview:self.commentBtn];
    self.commentBtn.frame = commentBtnRect;
    
    CGRect upvoteBtnRect = CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, 59);
    self.upvoteBtn = [[UIButton alloc] init];
    [self addSubview:self.upvoteBtn];
    self.upvoteBtn.frame = upvoteBtnRect;
    
    CGRect subview1Rect = CGRectMake(59/375.0 * SCREEN_WIDTH, 19, 22, 22);
    CGRect subview2Rect = CGRectMake(subview1Rect.origin.x + 22 + 11, 21, 36, 17);
    
    self.commentIconImageView = [[UIImageView alloc] initWithFrame:subview1Rect];
    [self.commentBtn addSubview:self.commentIconImageView];
    self.commentIconImageView.image = [UIImage imageNamed:@"icon_comment_inside"];
    self.commentIconImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.commentTitleImageView = [[UIImageView alloc] initWithFrame:subview2Rect];
    [self.commentBtn addSubview:self.commentTitleImageView];
    self.commentTitleImageView.image = [UIImage imageNamed:@"LXCommentTitle"];
    self.commentTitleImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.upvoteImageView = [[UIImageView alloc] initWithFrame:subview1Rect];
    [self.upvoteBtn addSubview:self.upvoteImageView];
    self.upvoteImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.numberOfUpvoteLabel = [[UILabel alloc] initWithFrame:subview2Rect];
    [self.upvoteBtn addSubview:self.numberOfUpvoteLabel];
    self.numberOfUpvoteLabel.text = @"0";
    self.numberOfUpvoteLabel.textColor = [UIColor colorWithRed:120/255.0 green:142/255.0 blue:250/255.0 alpha:1];
    self.numberOfUpvoteLabel.font = [UIFont systemFontOfSize:18];
    
    self.numberOfUpvoteLabel.textAlignment = NSTextAlignmentLeft;
    
    self.dottedLineView = [[UIView alloc] init];
    [self.upvoteBtn addSubview:self.dottedLineView];
    self.dottedLineView.frame = CGRectMake(0, self.upvoteBtn.frame.origin.y + 10, 2, self.upvoteBtn.frame.size.height - 20);
    self.dottedLineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
}

@end
