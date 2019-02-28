//
//  LostViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LostViewController.h"
#import "SegmentView.h"
#import "LostTableViewController.h"
#import "IssueTableViewController.h"
#import "IssueTableViewController.h"
#import "LoginViewController.h"
@interface LostViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) SegmentView *lostSegmentView;
@property (nonatomic, strong) SegmentView *foundSegmentView;
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation LostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"失物启事",@"招领启事"]];
    self.navigationItem.titleView = self.segmentedControl;
//    self.segmentedControl.tintColor = [UIColor colorWithRed:65/255.f green:163/255.f blue:255/255.f alpha:1];
    self.segmentedControl.tintColor = [UIColor whiteColor];
    [self.segmentedControl addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setSelectedSegmentIndex:0];
    
    
    NSArray *array = @[@"全部",@"一卡通",@"钱包",@"电子产品",@"书包",@"钥匙",@"雨伞",@"衣物",@"其他"];
    NSMutableArray *lostArray = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableArray *foundArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i<array.count; i++) {
        LostTableViewController *vc = [[LostTableViewController alloc]initWithTitle:array[i] Theme:LZLost];
        [self addChildViewController:vc];
        lostArray[i] = vc;
    }
    for (int i = 0; i<array.count; i++) {
        LostTableViewController *vc = [[LostTableViewController alloc]initWithTitle:array[i] Theme:LZFound];
        [self addChildViewController:vc];
        foundArray[i] = vc;
    }
    
    self.lostSegmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, ScreenHeight-HEADERHEIGHT) andControllers:[NSArray arrayWithArray:lostArray]];
    self.foundSegmentView =  [[SegmentView alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, ScreenHeight-HEADERHEIGHT) andControllers:[NSArray arrayWithArray:foundArray]];
    [self.view addSubview:self.lostSegmentView];
    
    self.addBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, 400, 100, 100)];
    [self.addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setImage:[UIImage imageNamed:@"lost_image_add"] forState:UIControlStateNormal];
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAction{
    IssueTableViewController *vc = [[IssueTableViewController alloc]init];
    NSString *stuNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"stuNum"];
    if (stuNum == nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"你还未登录 不能发布信息哦" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController presentViewController:login animated:YES completion:nil];
            login.loginSuccessHandler = ^(BOOL success) {
                if (success) {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:action];
        [alertController addAction:ok];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)action:(UISegmentedControl *)segment{
    [self.addBtn removeFromSuperview];
    NSString *title = [segment titleForSegmentAtIndex:segment.selectedSegmentIndex];
    if ([title isEqualToString:@"失物启事"]) {
        [self.foundSegmentView removeFromSuperview];
        [self.view addSubview:self.lostSegmentView];
    }
    else if([title isEqualToString:@"招领启事"]){
        [self.lostSegmentView removeFromSuperview];
        [self.view addSubview:self.foundSegmentView];
    }
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    }];
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
