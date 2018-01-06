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
        launchScreen.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        UIImageView *splashView = [launchScreen.subviews lastObject];
        splashView.userInteractionEnabled = YES;
        [launchScreen addSubview:splashView];
        splashView.contentMode = UIViewContentModeScaleAspectFill;
        splashView.image = image;
        splashView.frame = splashView.bounds;
        UIButton *skipBtn = [[UIButton alloc]init];
        [splashView addSubview:skipBtn];
        [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(splashView).offset(-20);
            make.top.equalTo(splashView).offset(20);
        }];
        [skipBtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:launchScreen];
        [self.view.window bringSubviewToFront:launchScreen];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.view.window.rootViewController = self.mainVC;
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
    if (![self.model.target_url isEqualToString:@""]) {
        self.view.window.rootViewController = self.mainVC;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"touchSplash" object:self.model.target_url];
    }
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
