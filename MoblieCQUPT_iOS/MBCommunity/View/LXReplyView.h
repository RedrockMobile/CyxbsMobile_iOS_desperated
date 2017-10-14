//
//  LXReplyView.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/9/6.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXReplyView : UIView

@property (strong, nonatomic) UIButton *commentBtn;
@property (strong, nonatomic) UIButton *upvoteBtn;
@property (strong, nonatomic) UIImageView *upvoteImageView;
@property (strong, nonatomic) UILabel *numberOfUpvoteLabel;
@property (strong, nonatomic) UIView *dottedLineView;

@end
