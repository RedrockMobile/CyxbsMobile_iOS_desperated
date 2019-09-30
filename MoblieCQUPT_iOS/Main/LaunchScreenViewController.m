//
//  LaunchScreenViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "SplashModel.h"
#import "MainViewController.h"
@interface LaunchScreenViewController ()
@property (nonatomic, strong) SplashModel *model;
@property (nonatomic, strong) MainViewController *mainVC;
@end

@implementation LaunchScreenViewController

- (instancetype)initWithSplashModel:(SplashModel *)splashModel{
    self = [self init];
    if (self) {
        self.model = splashModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImage{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"splash.png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
    if (image && self.model) {
        self.mainVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MainViewController"];
        UIView *launchScreen = [[[NSBundle mainBundle]loadNibNamed:@"LaunchScreen" owner:nil options:nil] lastObject];
        launchScreen.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIImageView *splashView = [launchScreen.subviews lastObject];
        splashView.userInteractionEnabled = YES;
        [launchScreen addSubview:splashView];
        splashView.contentMode = UIViewContentModeScaleAspectFill;
        splashView.image = image;
        splashView.frame = splashView.bounds;
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor whiteColor];
        [splashView addSubview:bottomView];

        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.bottom.equalTo(splashView);
            make.height.equalTo(@87);
        }];
        
        UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        skipBtn.clipsToBounds = YES;
        skipBtn.layer.cornerRadius = 15;
        skipBtn.backgroundColor = [UIColor whiteColor];
        skipBtn.layer.borderWidth = 1;
        skipBtn.layer.borderColor = [UIColor colorWithRed:221/255.0 green:211/255.0 blue:221/255.0 alpha:1].CGColor;
        [bottomView addSubview:skipBtn];
        
        UILabel *skipLabel = [[UILabel alloc] init];
        skipLabel.text = @"跳过";
        [skipBtn addSubview:skipLabel];
        skipLabel.font = [UIFont systemFontOfSize:14];
        skipLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"3";
        [skipBtn addSubview:timeLabel];
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textColor = [UIColor colorWithRed:117/255.0 green:144/255.0 blue:249/255.0 alpha:1];
        
        UIImageView *logoImageView = [[UIImageView alloc] init];
        logoImageView.image = [UIImage imageNamed:@"掌邮闪屏页"];
        [bottomView addSubview:logoImageView];
        
        if (IS_IPHONEX) {
            [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@57);
                make.width.equalTo(@114);
                make.right.equalTo(splashView).offset(-18);
                make.bottom.equalTo(splashView).offset(-20);
            }];
            skipBtn.clipsToBounds = YES;
            skipBtn.layer.cornerRadius = 28.5;
            
            [skipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(skipBtn).offset(27);
                make.centerY.equalTo(skipBtn);
            }];
            
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(skipLabel.mas_right).offset(9);
                make.centerY.equalTo(skipBtn);
            }];
            
            [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(bottomView);
                make.bottom.equalTo(bottomView).offset(-40);
                make.width.equalTo(@123);
                make.height.equalTo(@37);
            }];
        } else {
            [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@38);
                make.width.equalTo(@76);
                make.right.equalTo(splashView).offset(-12);
                make.bottom.equalTo(splashView).offset(-13);
            }];
            skipBtn.clipsToBounds = YES;
            skipBtn.layer.cornerRadius = 19;
            
            [skipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(skipBtn).offset(18);
                make.centerY.equalTo(skipBtn);
            }];
            
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(skipLabel.mas_right).offset(6);
                make.centerY.equalTo(skipBtn);
            }];
            
            [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(bottomView);
                make.bottom.equalTo(bottomView).offset(-27);
                make.width.equalTo(@123);
                make.height.equalTo(@37);
            }];
        }
        
        [skipBtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:launchScreen];
        [self.view.window bringSubviewToFront:launchScreen];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.view.window.rootViewController = self.mainVC;
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            timeLabel.text = @"2";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    timeLabel.text = @"1";
            });
        });
//        [UIView animateWithDuration:3 animations:^{
//            splashView.transform = CGAffineTransformMakeScale(1.2,1.2);
//            splashView.alpha = 0;
//        } completion:^(BOOL finished) {
//            [launchScreen removeFromSuperview];
//            self.view.window.rootViewController = mainVC;
//        }];
    }
}

- (void)skip{
    self.view.window.rootViewController = self.mainVC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (![self.model.target_url isEqualToString:@""]) {
//        self.view.window.rootViewController = self.mainVC;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"touchSplash" object:self.model.target_url];
//    }
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
