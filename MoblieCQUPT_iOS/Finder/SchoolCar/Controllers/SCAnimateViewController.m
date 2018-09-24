//
//  SCAnimateViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 周杰 on 2018/3/26.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SCAnimateViewController.h"
#import<libkern/OSAtomic.h>
#import "SchoolCarController.h"
#import "SchoolCarModel.h"

#define timeIntence 5.0//图片放大的时间
@interface SCAnimateViewController ()
@property (strong, nonatomic) UIImageView *bgdimgView;
@property (strong, nonatomic) UIImageView *carimgView;
@property (strong, nonatomic) UIButton *skipButton;
@end

@implementation SCAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)viewWillAppear:(BOOL)animated{
    //获取中心点xy坐标
    float x = [UIScreen mainScreen].bounds.size.width/2;
    float y = [UIScreen mainScreen].bounds.size.height/2;
    self.bgdimgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgdimgView.center = CGPointMake(x, y);
    self.bgdimgView.userInteractionEnabled = YES;
    self.carimgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"新校车"]];
    self.carimgView.center = CGPointMake(0, 370);
    self.bgdimgView.image = [UIImage imageNamed:@"开场背景"];
    [self.bgdimgView addSubview:self.carimgView];
    [self.view addSubview:_bgdimgView];
    [self.view bringSubviewToFront:self.bgdimgView];
    
//    //添加一个跳过按钮
//    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.skipButton.frame = CGRectMake(2*x - 80, 80, 70, 25);
//    self.skipButton.layer.cornerRadius = 12.5;
//    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.skipButton.backgroundColor = [UIColor grayColor];
//    [self.skipButton addTarget:self action:@selector(skipAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:self.skipButton];
//    //跳过按钮的倒计时
//    __block int32_t timeOutCount=timeIntence;
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(timer, ^{
//        OSAtomicDecrement32(&timeOutCount);
//        if (timeOutCount == 0) {
//            NSLog(@"timersource cancel");
//            dispatch_source_cancel(timer);
//        }
//        [self.skipButton setTitle:[NSString stringWithFormat:@"%d 跳过",timeOutCount+1] forState:(UIControlStateNormal)];
//    });
//    dispatch_source_set_cancel_handler(timer, ^{
//        NSLog(@"timersource cancel handle block");
//    });
//    dispatch_resume(timer);
    //图片移动动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeIntence];
    
    self.carimgView.transform = CGAffineTransformMakeTranslation(375*1.5, 0);
    [UIView commitAnimations];
    //图片消失动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeIntence * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0 animations:^{
            self.bgdimgView.alpha = 0;
            self.skipButton.alpha = 0;
          
        }];
    });
    //所有动画完成，删除图片和按钮
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((timeIntence + 1.0) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bgdimgView removeFromSuperview];
        [self.skipButton removeFromSuperview];
        SchoolCarController *vc = [[SchoolCarController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        
    });
    
}

////点击跳过按钮，删除图片和按钮
//-(void)skipAction:(UIButton*)sender{
//    [self.bgdimgView removeFromSuperview];
//    [self.skipButton removeFromSuperview];
//    SchoolCarController *vc = [[SchoolCarController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
