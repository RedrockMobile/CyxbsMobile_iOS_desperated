//
//  MBReleaseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/27.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBReleaseViewController.h"
#import "MBAddPhotoContainerView.h"

@interface MBReleaseViewController ()<MBAddPhotoContainerViewAddEventDelegate>

//@property (strong, nonatomic) UIButton *doneBtn;
//@property (strong, nonatomic) UIButton *cancelBtn;

@property (strong, nonatomic) UIView *navigationView;
@property (strong, nonatomic) MBInputView *inputView;


@end

@implementation MBReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.inputView];
    self.view.backgroundColor = BACK_GRAY_COLOR;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _navigationView.backgroundColor = MAIN_COLOR;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        titleLabel.text = @"哔哔叨叨";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(ScreenWidth/2, 42);
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [cancelBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [doneBtn sizeToFit];
        [cancelBtn sizeToFit];
        
        doneBtn.center = CGPointMake(ScreenWidth - 15 - doneBtn.frame.size.width/2, 42);
        cancelBtn.center = CGPointMake(15 + cancelBtn.frame.size.width/2, 42);
        
        [doneBtn addTarget:self action:@selector(clickDone:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
        
        [_navigationView addSubview:doneBtn];
        [_navigationView addSubview:cancelBtn];
        
        [_navigationView addSubview:titleLabel];
    }
    
    return _navigationView;
}

- (MBInputView *)inputView {
    if (!_inputView) {
        _inputView = [[MBInputView alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 250) withInptuViewStyle:MBInputViewStyleWithPhoto];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.textView.backgroundColor = [UIColor redColor];
        _inputView.textView.placeholder = @"和大家一起哔哔叨叨吧";
        _inputView.container.eventDelegate = self;
    }
    return _inputView;
}

- (void)clickPhotoContainerViewAdd {
    NSLog(@"点击添加图片");
    
    NSArray *pic = @[@"图片1.png",@"图片2.png",@"图片3.png",@"图片4.png",@"图片5.png"];
    NSMutableArray *picMutable = [NSMutableArray array];
    for (int i = 0; i < 9; i ++) {
        int index = arc4random()%3;
        [picMutable addObject:pic[index]];
    }
    
    _inputView.container.sourcePicArray = [picMutable copy];
}

- (void)clickDone:(UIButton *)sender {
    NSLog(@"点击完成");
}

- (void)clickCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
