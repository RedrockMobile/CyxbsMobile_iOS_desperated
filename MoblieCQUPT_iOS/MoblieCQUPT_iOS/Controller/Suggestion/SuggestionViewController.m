//
//  SuggestionViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/3.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "SuggestionViewController.h"
#import "ProgressHUD.h"

@interface SuggestionViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UITextView *suggestText;
@property (strong, nonatomic) UIBarButtonItem *send;
@property (strong, nonatomic) UIButton *sendButton;
@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (UITextView *)suggestText{
    if (!_suggestText) {
        _suggestText = [[UITextView alloc] initWithFrame:CGRectMake(20, 64+20, MAIN_SCREEN_W-40, MAIN_SCREEN_H*0.4)];
//        _suggestText.backgroundColor = [UIColor blueColor];
        
        _suggestText.layer.borderColor = [UIColor grayColor].CGColor;
        _suggestText.layer.borderWidth = 1;
        _suggestText.layer.cornerRadius = 8;
        _suggestText.backgroundColor = [MAIN_COLOR colorWithAlphaComponent:0.2];
        _suggestText.contentSize = CGSizeMake(_suggestText.frame.size.width, _suggestText.frame.size.height);
        _suggestText.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _suggestText.delegate = self;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
//        _suggestText.tintAdjustmentMode = NO;
//        _suggestText.textColor = [UIColor whiteColor];

    }
    return _suggestText;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _sendButton.frame = CGRectMake(20, 400, 200, 30);
        _sendButton.titleLabel.text = @"kkk";
        
        _sendButton.titleLabel.textColor = [UIColor yellowColor];
        
        _sendButton.layer.cornerRadius = 6;
//        _sendButton.backgroundColor = [UIColor redColor];
    }
    
    return _sendButton;
}

- (UIBarButtonItem *)send{
    if (!_send) {
        _send = [[UIBarButtonItem alloc]initWithTitle:@"反馈" style:UIBarButtonItemStylePlain target:self action:@selector(sendSuggest)];
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
    [self.view addSubview:self.suggestText];
    [self.view addSubview:self.sendButton];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.suggestText.text.length > 5) {
        self.navigationItem.rightBarButtonItem = self.send;
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}


-(void)sendSuggest{
    NSString *deviceInfo = [NSString stringWithFormat:@"iOS:%@+H:%f+W:%f",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],MAIN_SCREEN_H,MAIN_SCREEN_W];
    NSDictionary *dic = @{
                        @"paw":@"cyxbs_suggestion",
                        @"deviceInfo":deviceInfo,
                        @"content":self.suggestText.text,
                        };
    [ProgressHUD show:@"反馈中..."];
    [NetWork NetRequestPOSTWithRequestURL:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/registSuggestion" WithParameter:dic WithReturnValeuBlock:^(id returnValue) {
        [ProgressHUD showSuccess:@"反馈成功"];
//        NSLog(@"%@",returnValue);
        _suggestText.text = @"";
    } WithFailureBlock:^{
        [ProgressHUD showError:@"网络故障!"];
    }];

}

@end
