//
//  StuRootViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/7.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "StuRootViewController.h"
#import "OriginalViewController.h"
#import "SegmentView.h"
#import "CQUPTStudentsViewController.h"
#import "CQUPTBeautyViewController.h"
#import "OriginazitionOfCQUPTController.h"
#import "CQUPTTeacherView.h"
#import "MBProgressHUD.h"
@interface StuRootViewController ()
@property (strong, nonatomic)NSDictionary *dic;
@end

@implementation StuRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    MBProgressHUD *juhua = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    juhua.opacity = YES;
//    juhua.mode =  MBProgressHUDModeDeterminateHorizontalBar;
//    [juhua hide:YES afterDelay:10];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    OriginazitionOfCQUPTController *vc1 = [[OriginazitionOfCQUPTController alloc]init];
    vc1.title = @"学校组织";
    OriginalViewController * vc2 = [[OriginalViewController alloc]init];
    vc2.title = @"原创重邮";
    CQUPTBeautyViewController *vc3 = [[CQUPTBeautyViewController alloc] init];
    vc3.title = @"美在重邮";
    CQUPTTeacherView *vc4 =[[CQUPTTeacherView alloc] init];
    vc4.title = @"优秀老师";
    CQUPTStudentsViewController *vc5 = [[CQUPTStudentsViewController alloc] init];
    vc5.title = @"优秀学生";
    NSArray *vcArray = @[vc1,vc2,vc3,vc4,vc5];
    
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.bounds.size.height - 20) andControllers:vcArray];
    [self addChildViewController:vc2];
    [self.view addSubview:segmentView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#define url @"http://yangruixin.com/test/apiForText.php"
//- (void)getNet:(NSString *)item{
//    NSDictionary *params = @{@"RequestType": item};
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
//    NSMutableSet *acceptableSet = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
//    [acceptableSet addObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = acceptableSet;
//    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id  responseObject) {
//        NSData * data = [[NSData alloc]initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
//        //        使用系统自带JSON解析 并保存给id类型的对象（也可以是你接口中显示的类型）
//        _dic = [[NSDictionary alloc]init];
//        _dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        //        [self setDic: (NSDictionary *)responseObject];
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"失败了");
//    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
