//
//  MineViewController.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/30.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIImageView *myPhoto;
@property (strong, nonatomic) UILabel *loginLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat currentHeight;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentHeight = 0;
    UIView *topView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H*0.35)];
    _currentHeight += topView.frame.size.height;
    
    topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topView];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.myPhoto];
    [self.view addSubview:self.loginLabel];
    
    //button
    for (int i=0; i<4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( MAIN_SCREEN_W/4*i, topView.frame.size.height, MAIN_SCREEN_W/4, MAIN_SCREEN_H*0.1)];
        button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        button.layer.borderWidth = 1;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_menu_%d.png",i+1]] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
    }
    
    _currentHeight += MAIN_SCREEN_H*0.1;

    [self.view addSubview:self.tableView];
    _currentHeight += _tableView.frame.size.height;
    
    
    
    // Do any additional setup after loading the view.
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _currentHeight, MAIN_SCREEN_W, MAIN_SCREEN_H-_currentHeight-44) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setAutoresizesSubviews:NO];
    }
    
    return _tableView;
}

- (UIImageView *)myPhoto{
    if (!_myPhoto) {
        _myPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W*0.2, MAIN_SCREEN_W*0.2)];
        _myPhoto.center = CGPointMake(MAIN_SCREEN_W/2, MAIN_SCREEN_H*0.12);
        [_myPhoto setImage:[UIImage imageNamed:@"main_login.png"]];
        _myPhoto.backgroundColor = [UIColor whiteColor];
        _myPhoto.layer.cornerRadius = _myPhoto.frame.size.width/2;
    }
    return _myPhoto;
}

- (UILabel *)loginLabel{
    if (!_loginLabel) {
        _loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,MAIN_SCREEN_W/2, 0)];
        _loginLabel.textColor = [UIColor greenColor];
        NSMutableAttributedString *loginText = [[NSMutableAttributedString alloc] initWithString:@"刘慧吱"];
        [loginText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 3)];
        _loginLabel.attributedText = loginText;
        _loginLabel.textAlignment = NSTextAlignmentCenter;
        
        [_loginLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [_loginLabel sizeToFit];
        _loginLabel.center = CGPointMake(MAIN_SCREEN_W/2, _myPhoto.center.y+_myPhoto.frame.size.height/2+_loginLabel.frame.size.height+8);
    }
    return _loginLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"butttonCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"butttonCell"];
        cell.textLabel.text = @"我的消息";
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Courier" size:20]];
//        cell.detailTextLabel.textColor = [UIColor groupTableViewBackgroundColor];
        cell.detailTextLabel.text = @">";
        cell.imageView.image = [UIImage imageNamed:@"icon_menu_2.png"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSSet *set = [NSSet setWithObjects:@0,@1,@4, nil];
    NSSet *nowSet = [NSSet setWithObject:[NSNumber numberWithInteger:section]];
    if ([nowSet isSubsetOfSet:set]) {
        return 8;
    }else{
        return 0.000001;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (_tableView.frame.size.height-8*3-2)/5;
}

@end
