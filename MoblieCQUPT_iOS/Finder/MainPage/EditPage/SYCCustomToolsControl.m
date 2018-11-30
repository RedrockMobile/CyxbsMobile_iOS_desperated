//
//  SYCCustomToolsControl.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import "SYCCustomToolsControl.h"
#import "SYCEditToolsView.h"

@interface SYCCustomToolsControl ()
{
    UINavigationController *_nav;
    
    SYCEditToolsView *_channelView;
    
    ChannelBlock _block;
}
@end

@implementation SYCCustomToolsControl

+ (SYCCustomToolsControl *)shareControl{
    static SYCCustomToolsControl *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[SYCCustomToolsControl alloc] init];
    });
    MAIN_COLOR
    return control;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self buildChannelView];
    }
    return self;
}

- (void)buildChannelView{
    
    _channelView = [[SYCEditToolsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _nav = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    _nav.navigationBar.tintColor = [UIColor blackColor];
    _nav.topViewController.title = @"工具管理";
    _nav.topViewController.view = _channelView;
    _nav.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backMethod)];
}

- (void)backMethod
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _nav.view.frame;
        frame.origin.y = - _nav.view.bounds.size.height;
        _nav.view.frame = frame;
    }completion:^(BOOL finished) {
        [_nav.view removeFromSuperview];
    }];
    _block(_channelView.inUseTools ,_channelView.unUseTools);
}

- (void)showChannelViewWithInUseTitles:(NSArray*)inUseTitles unUseTitles:(NSArray*)unUseTitles finish:(ChannelBlock)block{
    _block = block;
    _channelView.inUseTools = [NSMutableArray arrayWithArray:inUseTitles];
    _channelView.unUseTools = [NSMutableArray arrayWithArray:unUseTitles];
    [_channelView reloadData];
    
    CGRect frame = _nav.view.frame;
    frame.origin.y = - _nav.view.bounds.size.height;
    _nav.view.frame = frame;
    _nav.view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_nav.view];
    [UIView animateWithDuration:0.3 animations:^{
        _nav.view.alpha = 1;
        _nav.view.frame = [UIScreen mainScreen].bounds;
    }];
}

@end

