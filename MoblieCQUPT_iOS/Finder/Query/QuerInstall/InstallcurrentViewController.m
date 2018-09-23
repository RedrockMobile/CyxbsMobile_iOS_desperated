//
//  InstallcurrentViewController.m
//  Query
//
//  Created by hzl on 2017/3/11.
//  Copyright © 2017年 c. All rights reserved.
//

#import "InstallcurrentViewController.h"
#import "InstallRoomViewController.h"
#import "AppDelegate.h"
#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0

CG_INLINE CGRect
CHANGE_CGRectMake(CGFloat x, CGFloat y,CGFloat width,CGFloat height){

    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleY;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@interface InstallcurrentViewController ()

@end

@implementation InstallcurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTitleView];
    [self addTitleLabel];
    [self addRoomLabel];
    [self addUnitLabel];
    [self addBuildLabel];
    [self addInstallBtn];
}

- (void)addTitleView{
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reinstallImage.png"]];
    //
    titleView.frame = CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, (SCREENHEIGHT - 60) / 2);
    //titleView.frame = CGRectMake(0, SCREENHEIGHT * 0.09 - 7, SCREENWIDTH, SCREENHEIGHT * 0.75 / 2);
    titleView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:titleView];
}

- (void)addTitleLabel{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(144, 399, 95, 16)];
    titleLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:font(15)];
    titleLabel.text = @"当前设置寝室";
    [self.view addSubview:titleLabel];
}

- (void)addBuildLabel{
    UILabel *buildLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(109, 435, 60, 50)];
    buildLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:font(45)];
    buildLabel.textAlignment = NSTextAlignmentCenter;
    buildLabel.textColor = [UIColor colorWithRed:27/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = pathArray[0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    buildLabel.text = data[@"build"];
    [self.view addSubview:buildLabel];
}

- (void)addUnitLabel{
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(162, 457, 22, 22)];
    unitLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:font(18)];
    unitLabel.textAlignment = NSTextAlignmentCenter;
    unitLabel.textColor = [UIColor colorWithRed:27/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    unitLabel.text = @"栋";
    [self.view addSubview:unitLabel];
}

- (void)addRoomLabel{
    UILabel *roomLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(183.5, 435, 80, 50)];
    roomLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:font(45)];
    roomLabel.textAlignment = NSTextAlignmentCenter;
    roomLabel.textColor = [UIColor colorWithRed:27/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = pathArray[0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    roomLabel.text = data[@"room"];
    [self.view addSubview:roomLabel];
}

- (void)addInstallBtn{
    UIButton *installBtn = [[UIButton alloc] initWithFrame:CHANGE_CGRectMake(44, 545, 288, 46)];
    
    [installBtn setTitle:@"重新设置" forState:UIControlStateNormal];
    [installBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    installBtn.backgroundColor = [UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1];
    [installBtn addTarget:self action:@selector(pushToInstallView) forControlEvents:UIControlEventTouchDown];
    
    installBtn.layer.cornerRadius = 23;
    installBtn.layer.masksToBounds = YES;
    
    [self.view addSubview:installBtn];
    
}

- (void)pushToInstallView{
    InstallRoomViewController *irVC = [[InstallRoomViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:irVC animated:YES];
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
