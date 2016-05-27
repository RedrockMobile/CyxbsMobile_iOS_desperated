//
//  TWGameControllButton.m
//  Tower
//
//  Created by Jonear on 14/12/20.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import "TWGameControllButton.h"

#define ButtonOffset 45
@implementation TWGameControllButton {
    UIImageView *_backgroundView;
    NSTimer *_touchTimer;
    NSInteger _direction;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 124, 124)];
        _backgroundView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [_backgroundView setImage:[UIImage imageNamed:@"btn_normal"]];
        [self addSubview:_backgroundView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopTimer) name:NOTI_StopControllerTimer object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopTimer) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //
    [self addTarget:nil action:nil forControlEvents:nil];
    id touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self];
    
    [self toucheClick:touchLocation withIsMoving:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    id touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self];
    
    [self toucheClick:touchLocation withIsMoving:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self stopTimer];
}

- (void)stopTimer {
    [_backgroundView setImage:[UIImage imageNamed:@"btn_normal"]];
    if (_touchTimer) {
        [_touchTimer invalidate];
        _touchTimer = nil;
    }
}

- (void)toucheClick:(CGPoint)touchLocation withIsMoving:(BOOL)isMoving {
    //获取矩形区域
    CGRect Rect = CGRectMake(touchLocation.x,
                             touchLocation.y,
                             1,
                             1);
    CGRect RectUp = CGRectMake(ButtonOffset,
                               0,
                               self.frame.size.width/2,
                               self.frame.size.height*2/5);
    CGRect RectDown = CGRectMake(ButtonOffset,
                                 self.frame.size.height*3/5,
                                 self.frame.size.width/2,
                                 self.frame.size.height/2);
    CGRect RectLeft = CGRectMake(0,
                                 ButtonOffset,
                                 self.frame.size.width/2,
                                 self.frame.size.height/2);
    CGRect RectRight = CGRectMake(self.frame.size.width/2,
                                  ButtonOffset,
                                  self.frame.size.width/2,
                                  self.frame.size.height/2);
    

    
    //检测触点是否在控件区
    if (CGRectIntersectsRect(Rect, RectUp)) {
        [_backgroundView setImage:[UIImage imageNamed:@"btn_up"]];
        _direction = 0;
    } else if (CGRectIntersectsRect(Rect, RectDown)) {
        [_backgroundView setImage:[UIImage imageNamed:@"btn_down"]];
        _direction = 1;
    } else if (CGRectIntersectsRect(Rect, RectLeft)) {
        [_backgroundView setImage:[UIImage imageNamed:@"btn_left"]];
        _direction = 2;
    } else if (CGRectIntersectsRect(Rect, RectRight)) {
        [_backgroundView setImage:[UIImage imageNamed:@"btn_right"]];
        _direction = 3;
    } else {
        return;
    }
    
    if (!isMoving) {
        if (!_touchTimer) {
            _touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(didSelectDirection) userInfo:nil repeats:YES];
        }
        
        [self didSelectDirection];
    }
}

- (void)didSelectDirection {
    if (_deleage && [_deleage respondsToSelector:@selector(didSelectClick:)]) {
        [_deleage didSelectClick:_direction];
    }
}

@end
