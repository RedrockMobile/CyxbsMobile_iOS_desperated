//
//  SuggestionViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/3.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "SuggestionViewController.h"
#import "ProgressHUD.h"
#import "ORWInputTextView.h"

@interface SuggestionViewController ()<UITextViewDelegate>
@property (strong, nonatomic) ORWInputTextView *suggestTextView;
@property (strong, nonatomic) UIBarButtonItem *send;

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGBColor(235, 240, 239, 1);
    
    _suggestTextView = [[ORWInputTextView alloc] initWithFrame:CGRectMake(20, 84, MAIN_SCREEN_W-40, (MAIN_SCREEN_W-40)/4)];
    [_suggestTextView setPlaceHolder:@"请描述一下您所遇到的程序错误,非常感谢您对掌上重邮成长的帮助。"];
    _suggestTextView.delegate = self;
    [self.view addSubview:_suggestTextView];
}


- (UIBarButtonItem *)send{
    if (!_send) {
        _send = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(sendSuggest)];
        _send.tintColor = [UIColor greenColor];
    }
    return _send;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.title = @"意见反馈";
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_suggestTextView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (_suggestTextView.text.length > 5) {
        self.navigationItem.rightBarButtonItem = self.send;
        
    }else if (_suggestTextView.text.length > 0){
        [_suggestTextView setPlaceHolder:@""];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
        [_suggestTextView setPlaceHolder:@"请描述一下您所遇到的程序错误,非常感谢您对掌上重邮成长的帮助。"];
    }
}


-(void)sendSuggest{
    NSString *deviceInfo = [NSString stringWithFormat:@"iOS:%@+H:%f+W:%f",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],MAIN_SCREEN_H,MAIN_SCREEN_W];
    NSDictionary *dic = @{
                        @"paw":@"cyxbs_suggestion",
                        @"deviceInfo":deviceInfo,
                        @"content":_suggestTextView.text,
                        };
    [ProgressHUD show:@"反馈中..."];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/registSuggestion" WithParameter:dic WithReturnValeuBlock:^(id returnValue) {
        [ProgressHUD showSuccess:@"反馈成功"];
//        NSLog(@"%@",returnValue);
        _suggestTextView.text = @"";
    } WithFailureBlock:^{
        [ProgressHUD showError:@"网络故障!"];
    }];

}

@end
