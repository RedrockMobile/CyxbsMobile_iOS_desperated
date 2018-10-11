//
//  ViewControl.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ChatViewControl.h"
#import "AFNetworking.h"
#import "Child_ChatViewControl01.h"
#import "Child_ChatViewControl02.h"

#define width [UIScreen mainScreen].bounds.size.width//宽
#define height [UIScreen mainScreen].bounds.size.height//高

@interface ChatViewControl ()

@end

@implementation ChatViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"线上交流";
    [self SetSegmentedControl:_MainSegmentView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewWillDisappear:(BOOL)animated{
    self.callBackHandle();
}


//创建segmentview
- (void)SetSegmentedControl:(SegmentView *)segmentedControl
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
    
    Child_ChatViewControl01 *vc1 = [[Child_ChatViewControl01 alloc] init];
    vc1.title = @"学院群";
    [self addChildViewController:vc1];
    array[0] = vc1;

    Child_ChatViewControl02 *vc2 = [[Child_ChatViewControl02 alloc] init];
    vc2.title = @"老乡群";
    [self addChildViewController:vc2];
    array[1] = vc2;

    segmentedControl = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, width, height-60) andControllers:[NSArray arrayWithArray:array]];
    segmentedControl.titleColor = [UIColor colorWithHexString:@"999999"];
    segmentedControl.selectedTitleColor = [UIColor colorWithHexString:@"54acff"];
    [self.view addSubview:segmentedControl];
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
