//
//  SuggestionViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/3.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController ()
@property (strong, nonatomic) UITextView *suggestText;
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
        _suggestText.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        self.automaticallyAdjustsScrollViewInsets = NO;
//        _suggestText.tintAdjustmentMode = NO;
//        _suggestText.textColor = [UIColor whiteColor];

    }
    return _suggestText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"意见反馈";
//    self.navigationController.navigationBar.backItem.title = @"返回";
    [self.view addSubview:self.suggestText];
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
