//
//  TW_ViewController.m
//  Tower
//
//  Created by Jonear on 14-5-10.
//  Copyright (c) 2014年 Jonear. All rights reserved.
//

#import "TW_ViewController.h"
#import "TW_MyScene.h"
#import "TWGameControllButton.h"

#define ControlButtonTag 120
#define ScrollButtonTag 313

@interface TW_ViewController() <TWGameControllButtonDelegate, UIAlertViewDelegate>

@end

@implementation TW_ViewController
{
    TW_MyScene *_mainScene;
    UIScrollView *_scrollerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRunToFloor:) name:NOTI_RunToFloor object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveGame) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    // Configure the view.

    [self initScene];
    [self initControllerButton];
    [self initFlyController];
}

- (void)initScene {
    self.view = [[SKView alloc]initWithFrame:self.view.frame];
    SKView * skView = (SKView *)self.view;

//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    _mainScene = [TW_MyScene sceneWithSize:CGSizeMake(PHOTOWIDTH, PHOTOHEIGHT)];
    _mainScene.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [skView presentScene:_mainScene];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft;
}


- (void)initControllerButton {
    TWGameControllButton *button = [[TWGameControllButton alloc] initWithFrame:CGRectMake(15, PHOTOHEIGHT-185, 150, 150)];
    [button setDeleage:self];
    [self.view addSubview:button];
    
    if (PHOTOWIDTH < 568) {
        button.alpha = 0.7;
    }
}

- (void)initFlyController {
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(PHOTOWIDTH-32, 0, 32, PHOTOHEIGHT)];
    [_scrollerView setBackgroundColor:[UIColor clearColor]];
    for (int i=0; i<=21; i++) {
        UILabel *button = [[UILabel alloc] initWithFrame:CGRectMake(0, i*32, 32, 32)];
        [button setText:[NSString stringWithFormat:@"%d", i]];
        [button setTag:i+ScrollButtonTag];
        if (i <= [_mainScene getMaxCanFlyIndex]) {
            [button setTextColor:[UIColor whiteColor]];
        } else {
            [button setTextColor:[UIColor lightGrayColor]];
        }
        [button setTextAlignment:NSTextAlignmentCenter];
        [_scrollerView addSubview:button];
    }
    [_scrollerView setContentSize:CGSizeMake(32, 32*22)];
    [_scrollerView setShowsVerticalScrollIndicator:NO];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flyButtonClick:)];
    [_scrollerView setUserInteractionEnabled:YES];
    [_scrollerView addGestureRecognizer:tapGesture];
    [_scrollerView setHidden:YES];
    if (APPDEBUG || [_mainScene getCanFlyFlag]) {
        [_scrollerView setHidden:NO];
        [self runToFloor:(int)[_mainScene getCurMapIndex]];
    }
    [self.view addSubview:_scrollerView];
}



- (void)runToFloor:(int)floorIndex {
    if (_scrollerView.isHidden && [_mainScene getCanFlyFlag]) {
        [_scrollerView setHidden:NO];
    } else if(![_mainScene getCanFlyFlag]) {
        [_scrollerView setHidden:YES];
    }

    for (int i=0; i<=21; i++) {
        UILabel *button = (UILabel *)[_scrollerView viewWithTag:i+ScrollButtonTag];
        if (button && i == floorIndex) {
            [button setBackgroundColor:[UIColor greenColor]];
        } else if (button) {
            [button setBackgroundColor:[UIColor clearColor]];
        }
        
        if (i <= [_mainScene getMaxCanFlyIndex]) {
            [button setTextColor:[UIColor whiteColor]];
        } else {
            [button setTextColor:[UIColor lightGrayColor]];
        }
    }
    
    int offset = floorIndex*32;
    if (offset>_scrollerView.contentOffset.y && offset<_scrollerView.contentOffset.y+PHOTOHEIGHT) {
        //在显示范围内
    } else if (offset<=_scrollerView.contentOffset.y) {
        [_scrollerView setContentOffset:CGPointMake(0, offset) animated:YES];
    } else if (offset>=_scrollerView.contentOffset.y+PHOTOHEIGHT) {
        [_scrollerView setContentOffset:CGPointMake(0, offset-PHOTOHEIGHT+32) animated:YES];
    }
    
}

- (void)didRunToFloor:(NSNotification *)notification {
    NSNumber *floor = notification.object;
    [self runToFloor:[floor intValue]];
}

- (void)flyButtonClick:(UITapGestureRecognizer *)tapGesture {
    //
    CGPoint point = [tapGesture locationInView:_scrollerView];
    int index = (int)(point.y/32);
    if (index <= [_mainScene getMaxCanFlyIndex]) {
        [_mainScene flyToMapWithIndex:index];
    }
}

- (void)saveGame {
    SKView *skView = (SKView *)self.view;
    skView.paused = YES;
    
    [_mainScene saveGame];
}

- (void)becomeActive {
    SKView *skView = (SKView *)self.view;
    skView.paused = NO;
}

- (void)didSelectClick:(NSInteger)index
{
    [_mainScene heroMoveTo:(enumHeroMove)index];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
