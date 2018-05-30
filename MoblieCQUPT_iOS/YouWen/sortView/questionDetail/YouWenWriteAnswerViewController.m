//
//  YouWenWriteAnswerViewController.m
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/7.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenWriteAnswerViewController.h"
#import <AFNetworking.h>
#import <Masonry.h>

#define ANSWERQUESTION @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Answer/add"

@interface YouWenWriteAnswerViewController ()<UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UILabel *placehoderLabel;
@end

@implementation YouWenWriteAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    [self setNav];
    [self setUI];
}


- (void)setNav {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commitComment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setUI {
    self.textView = [[UITextView alloc] init];
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.delegate = self;
    self.placehoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 19, SCREENWIDTH-16, 18)];
    self.placehoderLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.6];
    self.placehoderLabel.text = @"请尽可能给出明确的解决思路哦";
    self.placehoderLabel.font = [UIFont systemFontOfSize:16];
    [self.textView addSubview:self.placehoderLabel];
    [self.view addSubview:self.textView];
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@(320/667.0*SCREENHEIGHT));
    }];
    [self.textView layoutIfNeeded];
 
    
    //图片view
    UIView *picView = [[UIView alloc] init];
    [self.view addSubview:picView];
    [picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.textView.mas_bottom);
    }];
    
    //分割view
    UIView *bottomGrayView = [[UIView alloc] init];
    [picView addSubview:bottomGrayView];
    bottomGrayView.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.08];
    [bottomGrayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(picView);
        make.height.mas_equalTo(@(11/667.0*SCREENHEIGHT));
    }];
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 16, 109/375.0*SCREENWIDTH, 109/375.0*SCREENWIDTH)];
    self.imageView1.image = [UIImage imageNamed:@"加号"];
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15 * 2 + 109/375.0*SCREENWIDTH, 16, 109/375.0*SCREENWIDTH, 109/375.0*SCREENWIDTH)];
    [picView addSubview:self.imageView1];
    [picView addSubview:self.imageView2];
    
    self.imageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView1)];
    [self.imageView1 addGestureRecognizer:tap1];
    //0没图1有图
    self.imageView1.tag = 0;
    
    self.imageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView2)];
    [self.imageView2 addGestureRecognizer:tap2];
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)tapImageView1 {
    [self openPics];
}

- (void)tapImageView2 {
    if (self.imageView1.tag == 1) {
        [self openPics];
    }
}


- (void)openPics {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];//初始化图片选择控制器
    [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
    controller.delegate = self;// 设置代理
    [self presentViewController:controller animated:YES completion:^{
        
    }];//以模态的方式弹出视图
}

//得到图片或者视频后, 调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //在这个方法里我们可以进行图片的修改, 保存, 或者视频的保存
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.imageView1.tag == 0) {
        self.imageView1.image = image;
        self.imageView1.tag = 1;
    } else {
        self.imageView2.image = image;
        self.imageView2.tag = 1;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        if (!(self.imageView2.tag == 1)) {
            self.imageView2.image = [UIImage imageNamed:@"加号"];
        }
    }];
}

//当用户取消相册时, 调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//上传二进制流数据
- (void)commitComment {
//    NSData *imageData = UIImageJPEGRepresentation(self.imageView1.image, 0.5);
//    NSString *hex = [[NSString alloc] initWithData:hexData encoding:NSUTF8StringEncoding];

//    NSString *encodedString = [imageData base64EncodedString];
//    //16进制转2进制
//    NSMutableData *data = [NSMutableData dataWithCapacity:hex.length / 2];
//    unsigned char whole_byte;
//    char byte_chars[3] = {'\0','\0','\0'};
//    int i;
//    for (i=0; i < hex.length / 2; i++) {
//        byte_chars[0] = [hex characterAtIndex:i*2];
//        byte_chars[1] = [hex characterAtIndex:i*2+1];
//        whole_byte = strtol(byte_chars, NULL, 16);
//        [data appendBytes:&whole_byte length:1];
//    }
//
//    NSLog(@"%@", data);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{
                                 @"stuNum":[UserDefaultTool getStuNum],
                                 @"idNum":[UserDefaultTool getIdNum],
                                 @"content":self.textView.text,
                                 @"question":self.question_id
                                 };
    [manager POST:ANSWERQUESTION parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //返回前一个界面，刷新，弹出提示框
        NSLog(@"发送成功");
        [self.delegate reload];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@", error);
    }];
    
}

#pragma mark - textView

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placehoderLabel.hidden = YES;
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
