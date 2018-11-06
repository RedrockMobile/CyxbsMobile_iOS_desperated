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

@implementation InstallRoomDoneViewController

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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doneImage.png"]];
    imageView.frame = CGRectMake(SCREENWIDTH * 0.2, SCREENHEIGHT * 0.3, SCREENWIDTH * 0.6, SCREENWIDTH * 0.6);
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:imageView];
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
