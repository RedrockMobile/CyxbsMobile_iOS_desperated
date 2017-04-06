//
//  QuerRemindViewController.m
//  Query
//
//  Created by hzl on 2017/3/12.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerRemindViewController.h"
#import "InstallRoomDoneViewController.h"
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

@interface QuerRemindViewController ()

@property (nonatomic, strong) UITextField *remindTextField;
@property (nonatomic, strong) UIView *infoBigView;

@end

@implementation QuerRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1]};
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)]];
    
    self.navigationItem.title = @"设置提醒";
    [self addTitleView];
    [self addTitleRemindLabel];
    [self addUnitView];
    [self addTextField];
    [self addDoneBtn];
}

- (void)showInfoView{
    _infoBigView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(0, 0, 375, 667)];
    _infoBigView.backgroundColor = [UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:0.7];
    
    UIView *achieveView = [[UIView alloc] initWithFrame:CHANGE_CGRectMake(31, 174.5, 313, 319)];
    achieveView.layer.cornerRadius = 12;
    achieveView.layer.masksToBounds = YES;
    achieveView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"achieveImage.png"]];
    imageView.frame = CHANGE_CGRectMake(0, 0, 313, 187.5);
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(100.5, 213.5, 116, 20)];
    infoLabel.font = [UIFont systemFontOfSize:font(17)];
    infoLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.text = @"你还没有填写呢";
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.adjustsFontSizeToFitWidth = YES;
    infoLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    infoLabel.contentMode = UIViewContentModeRedraw;
    
    UIButton *achieveBtn = [[UIButton alloc] initWithFrame:CHANGE_CGRectMake(31, 264, 252, 41.5)];
    achieveBtn.backgroundColor = [UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1];
    [achieveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [achieveBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [achieveBtn addTarget:self action:@selector(removeInfoBigView) forControlEvents:UIControlEventTouchDown];
    achieveBtn.layer.cornerRadius = 5;
    achieveBtn.layer.masksToBounds = YES;
    
    [achieveView addSubview:imageView];
    [achieveView addSubview:infoLabel];
    [achieveView addSubview:achieveBtn];
    
    [_infoBigView addSubview:achieveView];
    [self.view addSubview:_infoBigView];
}

- (void)removeInfoBigView{
    _infoBigView.hidden = YES;
    _infoBigView = nil;
}

- (void)hideKeyBoard{
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}

- (void)addTitleView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"remindImage.png"]];
    imageView.frame = CHANGE_CGRectMake(0, 64, 375, 295);
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:imageView];
}

- (void)addTitleRemindLabel{
    UILabel *label = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(87, 403, 215, 20)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:font(17)];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    label.text = @"请输入一个最低电费提醒值";
    label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:label];
}

- (void)addUnitView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unitImage"]];
    imageView.frame = CHANGE_CGRectMake(108, 442, 33, 41);
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:imageView];
}


- (void)addTextField{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = pathArray[0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
    NSDictionary *dataDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    _remindTextField = [[UITextField alloc] initWithFrame:CHANGE_CGRectMake(155, 443, 180, 45)];
    _remindTextField.textAlignment = NSTextAlignmentLeft;
    _remindTextField.keyboardType = UIKeyboardTypeNumberPad;
      _remindTextField.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (dataDic[@"remind"]) {
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",dataDic[@"remind"]] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:1]}];
        [content addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:font(52)]} range:NSMakeRange(0, content.length)];
        _remindTextField.attributedPlaceholder = content;
    }
    _remindTextField.textColor = [UIColor colorWithRed:18/255.0 green:208/255.0 blue:255/255.0 alpha:1];
    [_remindTextField setFont:[UIFont fontWithName:@"Helvetica-Bold" size:font(55)]];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CHANGE_CGRectMake(106, 496.5, 185, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.5];
    _remindTextField.tintColor = [UIColor blackColor];
    
    [self.view addSubview:lineLabel];
    [self.view addSubview:_remindTextField];
}

- (void)addDoneBtn{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"确 定" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [content addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font(21)]} range:NSMakeRange(0, content.length)];
    
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CHANGE_CGRectMake(43.5, 544.5, 288,46)];
    [doneBtn setAttributedTitle:content forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorWithRed:18/255.0 green:185/255.0 blue:255/255.0 alpha:1];
    
    doneBtn.layer.cornerRadius = 23;
    doneBtn.layer.masksToBounds = YES;
    
    [doneBtn addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:doneBtn];
}

- (void)saveData{
    if (!_remindTextField.text.length) {
        [self showInfoView];
    }else{
        InstallRoomDoneViewController *irdVC = [[InstallRoomDoneViewController alloc] init];
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = pathArray[0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
    NSDictionary *dataDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    [dataDic setValue:_remindTextField.text forKey:@"remind"];
        [dataDic writeToFile:plistPath atomically:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:irdVC animated:YES];
   }
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
