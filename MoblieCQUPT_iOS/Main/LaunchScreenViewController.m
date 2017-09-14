//
//  LaunchScreenViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LaunchScreenViewController.h"
@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

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
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MainViewController"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"splash.png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
       if (image) {
           UIView *launchScreen = [[[NSBundle mainBundle]loadNibNamed:@"LaunchScreen" owner:nil options:nil] lastObject];
           launchScreen.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
           UIImageView *splashView = [launchScreen.subviews lastObject];
           [launchScreen addSubview:splashView];
           splashView.contentMode = UIViewContentModeScaleAspectFill;
           splashView.image = image;
           splashView.frame = splashView.bounds;
           [self.view addSubview:launchScreen];
           [self.view.window bringSubviewToFront:launchScreen];
           [UIView animateWithDuration:2 animations:^{
               splashView.transform = CGAffineTransformMakeScale(1.2,1.2);
               splashView.alpha = 0;
           } completion:^(BOOL finished) {
               [launchScreen removeFromSuperview];
               self.view.window.rootViewController = vc;
           }];
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
