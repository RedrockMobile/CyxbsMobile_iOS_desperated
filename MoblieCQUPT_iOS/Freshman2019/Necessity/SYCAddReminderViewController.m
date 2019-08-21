//
//  SYCAddReminderViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/8/21.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SYCAddReminderViewController.h"
#import "Model/DLNecessityModel.h"
#import <Masonry.h>

@interface SYCAddReminderViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *text;
@end

@implementation SYCAddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBColor(239, 247, 255, 1);
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"添加备忘物品";
    title.textColor = RGBColor(119, 119, 119, 1);
    title.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(TOTAL_TOP_HEIGHT + 15);
        make.left.equalTo(self.view).with.offset(16);
    }];
    
    UIView *textBackgrond = [[UIView alloc] init];
    textBackgrond.backgroundColor = [UIColor whiteColor];
    textBackgrond.layer.borderWidth = 0.5;
    textBackgrond.layer.borderColor = [RGBColor(191, 206, 255, 0.7) CGColor];
    [self.view addSubview:textBackgrond];
    [textBackgrond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(title.mas_bottom).with.offset(10);
        make.width.equalTo(self.view).multipliedBy(0.92);
        make.height.mas_equalTo(54);
    }];
    
    _text = [[UITextField alloc] init];
    _text.placeholder = @"输入不多于15个字";
    _text.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_text];
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.with.centerY.equalTo(textBackgrond);
        make.width.equalTo(textBackgrond).multipliedBy(0.9);
    }];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.title = @"备忘录";
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save{
    if (_text.text.length > 15) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"你的待办字数太多了ψ(｀∇´)ψ" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
        [_text becomeFirstResponder];
    }else if (_text.text.length == 0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"你没有输入任何待办哦(○o○)" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
        [_text becomeFirstResponder];
    }else{
        NSDictionary *dic = @{@"name":_text.text,
                              @"detail":@"",
                              };
        DLNecessityModel *model = [[DLNecessityModel alloc] initWithDic:dic];
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dataPath = [docPath stringByAppendingPathComponent:@"dataArray.archiver"];
        NSString *titlePath = [docPath stringByAppendingPathComponent:@"titleArray.archiver"];
        NSMutableArray *dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
        NSMutableArray *titleArray = [NSKeyedUnarchiver unarchiveObjectWithFile:titlePath];
        if ([titleArray[0] isEqual:@"备忘录"]) {
            [dataArray[0] addObject:model];
        }else{
            [titleArray insertObject:@"备忘录" atIndex:0];
            NSMutableArray<DLNecessityModel *> *models = [@[model] mutableCopy];
            [dataArray insertObject:models atIndex:0];
        }
        [NSKeyedArchiver archiveRootObject:dataArray toFile:dataPath];
        [NSKeyedArchiver archiveRootObject:titleArray toFile:titlePath];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

#pragma - 输入监听
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_text resignFirstResponder];
    return YES;
}



@end
