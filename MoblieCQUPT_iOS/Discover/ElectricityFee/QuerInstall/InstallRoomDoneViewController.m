//
//  InstallRoomDoneViewController.m
//  Query
//
//  Created by hzl on 2017/3/10.
//  Copyright © 2017年 c. All rights reserved.
//

#import "InstallRoomDoneViewController.h"
#import "InstallcurrentViewController.h"
#import "InstallRoomViewController.h"
#import "QuerLoginViewController.h"
#import "QuerRemindViewController.h"
#import "AppDelegate.h"

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){

    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleY;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@interface InstallRoomDoneViewController ()
@property(nonatomic,strong)UIImageView*imageView;

@end

@implementation InstallRoomDoneViewController

//- (BOOL)my_navigationControllershouldPopWhenSystemBackBtnSelected:(id)navigationController{
//    QuerLoginViewController *querVC = [[QuerLoginViewController alloc] init];
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[querVC class]]) {
//               [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
//    return NO;
//}

- (void)viewDidAppear:(BOOL)animated{
    NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.navigationController.viewControllers.count; i++) {
        if ([self.navigationController.viewControllers[i] isKindOfClass:[InstallRoomViewController class]]||[self.navigationController.viewControllers[i] isKindOfClass:[InstallcurrentViewController class]]||[self.navigationController.viewControllers[i] isKindOfClass:[QuerRemindViewController class]]) {
            [vcArray addObject:self.navigationController.viewControllers[i]];
        }
    }
    for (UIViewController *controller in vcArray) {
        [array removeObject:controller];
    }
    self.navigationController.viewControllers = [array copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doneImage.png"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
//    imageView.frame = CHANGE_CGRectMake(91.5, 187, 194, 208);

    

}

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
