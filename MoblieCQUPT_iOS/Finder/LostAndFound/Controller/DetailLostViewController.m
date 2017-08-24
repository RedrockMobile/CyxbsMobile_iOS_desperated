//
//  DetailLostViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/9.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "DetailLostViewController.h"
#import "IconTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface DetailLostViewController ()<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray *imageArray;
@property NSArray *titleArray;
@property NSMutableArray *contentArray;
@property MBProgressHUD *hud;
@property UIView *whiteView;
@end

@implementation DetailLostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细信息";
    [self initArray];
    self.footTableView.delegate = self;
    self.footTableView.dataSource = self;
    self.headImageView.layer.cornerRadius = self.headImageView.size.width/2;
    self.headImageView.layer.masksToBounds = YES;
    self.footTableView.tableFooterView = [[UIView alloc]init];
    [self.footTableView setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.footTableView.bounces = NO;
    self.footTableView.showsVerticalScrollIndicator = NO;
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.whiteView];
    self.hud=[MBProgressHUD showHUDAddedTo:self.whiteView animated:YES];
    self.hud.labelText=@"loading";
    // Do any additional setup after loading the view from its nib.
}

- (void)initArray{
    NSArray *imageTitleArray = @[@"lost_image_com.png",@"lost_image_time.png",@"lost_image_place.png",@"lost_image_tel.png",@"lost_image_QQ.png"];
    self.titleArray = @[@"联系人",@"时    间",@"地    点",@"电    话",@"Q      Q"];
    self.imageArray = [NSMutableArray arrayWithCapacity:imageTitleArray.count];
    self.contentArray = [NSMutableArray array];
    for (int i = 0; i<imageTitleArray.count; i++) {
        self.imageArray[i] = [UIImage imageNamed:imageTitleArray[i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshWithDetailInfo:(LostItem *)info{
    if([info.wx_avatar rangeOfString:@"http"].location != NSNotFound){
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:info.wx_avatar]];
    }
    else{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn%@",info.wx_avatar]]];
    }
    self.categoryLabel.text = info.pro_name;
    self.contentLabel.text = info.pro_description;
    self.nameLabel.text = info.connect_name;
    [self.contentArray addObject:info.connect_name];
    [self.contentArray addObject:info.L_or_F_time];
    [self.contentArray addObject:info.L_or_F_place];
    [self.contentArray addObject:info.connect_phone];
    [self.contentArray addObject:info.connect_wx];
    [self.whiteView removeFromSuperview];
    [self.hud hide:YES];
    [self.contentLabel sizeToFit];
    [self.footTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IconTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"IconTableViewCell" owner:nil options:nil] firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.row;
    cell.iconImageView.image = self.imageArray[index];
    cell.titleLabel.text = self.titleArray[index];
    if (self.contentArray.count > index) {
        cell.contentLabel.text = self.contentArray[index];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.footTableView.frame.size.height/5;
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
