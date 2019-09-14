//
//  LQQwantMoreViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/5.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQwantMoreViewController.h"
#import "QRCodeView.h"
#import "welcomeNewWebController.h"
#import "BaseNavigationController.h"
#import "MBProgressHUD.h"
@interface LQQwantMoreViewController ()<UIActionSheetDelegate,UIWebViewDelegate>
@property (nonatomic, strong)UIButton*number1;//重邮2019迎新专题
@property(nonatomic, strong)UIButton*number2;//掌上重邮新功能
@property(nonatomic, strong)UIButton*number3;//重邮小帮手
@property(nonatomic, strong)NSArray<UIButton*>*buttonArr;
@property(nonatomic, strong)UIImageView* backImage;
@property(nonatomic,strong)UIImageView * BoLi;
@property (nonatomic, weak) QRCodeView *QRCode;

@end

@implementation LQQwantMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildMyNavigationbar];
    [self makeButtonToArray];
    [self showButton];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:247/255.0 blue:255/255.0 alpha:1];
}
//
-(void)showButton{
    _number1 = [[UIButton alloc]init];
    _number2 = [[UIButton alloc]init];
    _number3 = [[UIButton alloc]init];
    [_number1 setImage:[UIImage imageNamed:@"LQQwantMore"] forState:UIControlStateNormal];
    [_number2 setImage:[UIImage imageNamed:@"LQQwantMore"] forState:UIControlStateNormal];
    [_number3 setImage:[UIImage imageNamed:@"LQQwantMore"] forState:UIControlStateNormal];
//    _number1.backgroundColor = [UIColor redColor];
//    _number2.backgroundColor = [UIColor redColor];
//    _number3.backgroundColor = [UIColor redColor];
    [self.view addSubview:_number1];
    [self.view addSubview:_number2];
    [self.view addSubview:_number3];
    [_number1 addTarget:self action:@selector(clicknumber1) forControlEvents:UIControlEventTouchUpInside];
    [_number2 addTarget:self action:@selector(clicknumber2) forControlEvents:UIControlEventTouchUpInside];
    [_number3 addTarget:self action:@selector(clicknumber3) forControlEvents:UIControlEventTouchUpInside];
    [_number1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@75);
        make.width.equalTo(self.view).multipliedBy(0.9);
        make.top.equalTo(self.view).offset(20);
    }];
    [_number2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->_number1);
        make.height.equalTo(self->_number1);
        make.width.equalTo(self->_number1);
        make.top.equalTo(self->_number1.mas_bottom).offset(20);
    }];
    [_number3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->_number1);
        make.height.equalTo(self->_number1);
        make.width.equalTo(self->_number1);
        make.top.equalTo(self->_number2.mas_bottom).offset(20);
    }];
    UILabel*title1 = [[UILabel alloc]init];
//    title1.backgroundColor =  [UIColor redColor];
    title1.text = @"重邮2019迎新专题";
    [_number1 addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_number1).offset(15);
//        make.centerY.equalTo(_number1);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
        make.left.equalTo(self->_number1).offset(25);
    }];
    [_number1 addSubview:title1];
    
    UILabel*detail1 = [[UILabel alloc]init];
    detail1.text = @"邮你造未来";
//    detail1.backgroundColor = [UIColor blueColor];
    [_number1 addSubview:detail1];
    [detail1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.mas_bottom);
        make.width.equalTo(@450);
        make.height.equalTo(@15);
        make.left.equalTo(self->_number1).offset(25);
    }];
    detail1.font = [UIFont systemFontOfSize:14];
    detail1.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    
    UILabel*title2 = [[UILabel alloc]init];
    title2.text = @"掌上重邮新功能";
    [_number2 addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_number2).offset(15);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
        make.left.equalTo(self->_number2).offset(25);
    }];
    [_number2 addSubview:title2];
    
    UILabel*detail2 = [[UILabel alloc]init];
    detail2.text = @"校车，校历等更多查询功能";
    [_number2 addSubview:detail2];
    [detail2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.mas_bottom);
        make.width.equalTo(@450);
        make.height.equalTo(@15);
        make.left.equalTo(self->_number2).offset(25);
    }];
    detail2.font = [UIFont systemFontOfSize:14];
    detail2.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];

    
    
    UILabel*title3 = [[UILabel alloc]init];
    title3.text = @"重邮小帮手";
    [_number3 addSubview:title3];
    [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_number3).offset(15);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
        make.left.equalTo(self->_number3).offset(25);
    }];
    [_number3 addSubview:title3];
    
    UILabel*detail3 = [[UILabel alloc]init];
    detail3.text = @"学长学姐帮帮忙";
    [_number3 addSubview:detail3];
    [detail3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title3.mas_bottom);
        make.width.equalTo(@450);
        make.height.equalTo(@15);
        make.left.equalTo(self->_number3).offset(25);
    }];
    detail3.font = [UIFont systemFontOfSize:14];
    detail3.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
}


-(void)makeButtonToArray{
    [_buttonArr arrayByAddingObject:_number1];
    [_buttonArr arrayByAddingObject:_number2];
    [_buttonArr arrayByAddingObject:_number3];
//    NSLog(@"LQQQQ%@",_buttonArr);

}
- (void)buildMyNavigationbar{
    

    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"更多功能";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    [titleView addSubview:titleLabel];
    
    
    self.navigationItem.titleView = titleView;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerX.equalTo(titleView);
        make.centerY.equalTo(titleView);
    }];

}
-(void)clicknumber1{

    welcomeNewWebController*controller = [[welcomeNewWebController alloc]init];
    BaseNavigationController*nav = [[BaseNavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
    




}
-(void)clicknumber2{
    //跳转至发现页面
    self.tabBarController.selectedIndex = 3;
}
-(void)clicknumber3{
    //毛玻璃
//    if (!_QRCode) {
//        QRCodeView *QRCode = [[QRCodeView alloc] initWithFrame:self.view.bounds];
//        [self.view addSubview:QRCode];
//        self.QRCode = QRCode;
//        [self.QRCode.cancelButton addTarget:self action:@selector(searchBarCancelButtonClicked1) forControlEvents:UIControlEventTouchUpInside];
//    } else {
//        self.QRCode.hidden = NO;
//    }
    
    _BoLi = [[UIImageView alloc]init];
    _BoLi.frame =CGRectMake(0, 0,self.view.width,self.view.height);
    _BoLi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _BoLi.alpha = 0;
    [self.view addSubview:_BoLi];

//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    [button addTarget:self action:@selector(removeErWeiMa) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    _backImage = [[UIImageView alloc]init];
    [_backImage setImage:[UIImage imageNamed:@"erWeiMaV2.0"]];
    [_BoLi addSubview:_backImage];
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->_BoLi);
        make.centerY.equalTo(self.navigationController.view);
        make.width.equalTo(self->_BoLi).multipliedBy(590.0/750);
        make.height.equalTo(self->_BoLi.mas_width).multipliedBy(590.0/750*(369/295.0));
//        make.height.equalTo(self.navigationController.view).multipliedBy(738.0/(298+298+738));
    }];
    [_backImage setUserInteractionEnabled:YES];
    [_BoLi setUserInteractionEnabled:YES];
    UILabel*bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _backImage.alpha = 0;
    [_backImage addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->_backImage);
        make.width.equalTo(self->_backImage).multipliedBy(447.0/(447+143));
//        make.height.equalTo(_backImage).multipliedBy(90.0/738);
        make.bottom.equalTo(self->_backImage.mas_bottom).offset(-40);
    }];
    bottomLabel.text = @"关注“重邮小帮手”微信公众号，参与学长学姐帮帮忙";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [bottomLabel setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:15.0f]];
    bottomLabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
//    bottomLabel.lineBreakMode = NSLineBreakByClipping;
    bottomLabel.numberOfLines = 0;



    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.backImage addGestureRecognizer:longPress];
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeErWeiMa)];
    [self.BoLi addGestureRecognizer:tap];

    UITapGestureRecognizer*tapErWeiMa = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(printThing)];
    [self.backImage addGestureRecognizer:tapErWeiMa];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.BoLi.alpha = 1;
        self.backImage.alpha = 1;
    }];
    
}
-(void)longPress:(UITapGestureRecognizer*)sender{
    if(sender.state == UIGestureRecognizerStateBegan){
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"保存二维码至个人相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"保存",nil];
        //展示活动列表
        [actionSheet showInView:self.view];
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED;
{
    if(buttonIndex == 0){
        NSLog(@"选择了%ld",buttonIndex);
         UIImageWriteToSavedPhotosAlbum([UIImage imageNamed:@"erWeiMaV2.0"], self, @selector(image:didFinshSavingWithError:contextInfo:), nil);
        [_BoLi removeFromSuperview];
        
    }else{
        NSLog(@"取消了");
        [_BoLi removeFromSuperview];
    }
}
- (void)image:(UIImage *)image didFinshSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"保存成功";
        [hud hide:YES afterDelay:1];
    }
}

- (void)removeErWeiMa{
    [self.backImage removeFromSuperview];
    [_BoLi removeFromSuperview];
}
- (void)printThing{
    NSLog(@"???");
}

- (void)searchBarCancelButtonClicked1 {
    self.QRCode.hidden = YES;
}

@end
