//
//  ZJShopDeatilViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 周杰 on 2017/11/20.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "ZJShopDeatilViewController.h"
#import "MJRefresh.h"
#import "ZJshopTableViewCell.h"
#import "ZJAddCommentView.h"
#define   UIWidth   [UIScreen mainScreen].bounds.size.width/375

@interface ZJShopDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *shopDetailTableView;
@property (strong, nonatomic) NSMutableDictionary *shopInfo;
@property (assign,nonatomic) NSInteger flag;
@property (strong, nonatomic) NSMutableArray *commentArray;
@property (copy, nonatomic) NSString *content;

@end

@implementation ZJShopDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _commentArray = [[NSMutableArray alloc]init];
    [self setRefresh];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加评论" style:UIBarButtonItemStylePlain target:self action:@selector(addComment)];;
    [self loadShopData];
    [self.view addSubview:self.shopDetailTableView];
}
//设置刷新
- (void)setRefresh{
    self.shopDetailTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)addComment{
    ZJAddCommentView *shopAddComment = [[ZJAddCommentView alloc]init];
    shopAddComment.markBlock = ^(int markView){
        if (markView == 0) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
        else{
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    };
    [shopAddComment showInView:self.view];
    __weak typeof(self) weakSelf = self;
    shopAddComment.AddCommentBlock = ^(NSString *str){
        [weakSelf addCommentData:str];
        
    };
}

//添加评论
-(void)addCommentData:(NSString *)content{
    NSString *strURL = [NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/addCom"];
//    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *stuName = [UserDefaultTool valueWithKey:@"name"];
//    NSString *idNUM  = [UserDefaultTool getIdNum];
    NSDictionary *parameter = @{
                                @"shop_id":_detailData[@"id"],
                                @"comment_author_name":stuName,
                                @"comment_content":content
                                };
    [NetWork NetRequestPOSTWithRequestURL:strURL WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        [self loadCommentData];
    } WithFailureBlock:^{
        UILabel* failLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        failLabel.text=@"哎呀，网坏了!";
        failLabel.textColor=[UIColor blackColor];
        failLabel.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        failLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.view addSubview:failLabel];
        [_shopDetailTableView removeFromSuperview];
    }];
    
}

//懒加载店面细节tableView
- (UITableView *)shopDetailTableView{
    if (!_shopDetailTableView) {
        _shopDetailTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _shopDetailTableView.delegate = self;
        _shopDetailTableView.dataSource = self;
        dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(defaultQueue, ^{
            [self loadShopData];
        });
        dispatch_async(defaultQueue, ^{
            [self loadCommentData];
        });
    }
    return _shopDetailTableView;
    
}
//获取店铺信息，第一个section
-(void)loadShopData{
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn/cyxbs_api_2014/cqupthelp/index.php/admin/shop/shopInfo" WithParameter:@{@"id":_detailData[@"id"]} WithReturnValeuBlock:^(id returnValue) {
        _shopInfo = [NSMutableDictionary dictionaryWithCapacity:10];
        [_shopInfo setObject:returnValue[@"data"] forKey:@"infoData"];
        [self.shopDetailTableView reloadData];
        
    } WithFailureBlock:^{
        UILabel* failLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        failLabel.text = @"哎呀，网坏了!";
        failLabel.textColor=[UIColor blackColor];
        failLabel.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        failLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:failLabel];
        [_shopDetailTableView removeFromSuperview];
    }];
}
//加载评论数据，第二个section
-(void)loadCommentData{
    _flag = 1;
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn//cyxbs_api_2014/cqupthelp/index.php/admin/shop/comList" WithParameter:@{@"shop_id":_detailData[@"id"],@"pid":[NSNumber numberWithInteger:_flag]} WithReturnValeuBlock:^(id returnValue) {
        _commentArray = [[NSMutableArray alloc]init];
        if ([returnValue isEqual:[NSNull null]]) {
            [self.shopDetailTableView.mj_footer endRefreshingWithNoMoreData];
        self.shopDetailTableView.mj_footer.backgroundColor = [UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1];
            return ;
        }
        [_commentArray addObjectsFromArray:[returnValue objectForKey:@"data"]];
        [_shopDetailTableView reloadData];
        if (_commentArray.count < 5) {
            [self.shopDetailTableView.mj_footer endRefreshingWithNoMoreData];
        self.shopDetailTableView.mj_footer.backgroundColor = [UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1];
        }
        
    } WithFailureBlock:^{
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_shopDetailTableView removeFromSuperview];
    }];
}
//尾部评论刷新
-(void)footerRefresh{
    _flag += 1;
    [NetWork NetRequestPOSTWithRequestURL:@"https://wx.idsbllp.cn//cyxbs_api_2014/cqupthelp/index.php/admin/shop/comList" WithParameter:@{@"shop_id":_detailData[@"id"],@"pid":[NSNumber numberWithInteger:_flag]} WithReturnValeuBlock:^(id returnValue) {
        if ([returnValue isEqual:[NSNull null]]) {
            [self.shopDetailTableView.mj_footer endRefreshingWithNoMoreData];
            self.shopDetailTableView.mj_footer.backgroundColor = [UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1];
            return ;
        }
        [_commentArray addObjectsFromArray:[returnValue objectForKey:@"data"]];
        if ([[returnValue objectForKey:@"data"]isEqual:[NSNull null]]) {
            [self.shopDetailTableView.mj_footer endRefreshingWithNoMoreData];
            self.shopDetailTableView.mj_footer.backgroundColor = [UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1];
            return ;
        }
        [_shopDetailTableView reloadData];
        if (_commentArray.count < 5 * _flag) {
            [self.shopDetailTableView.mj_footer endRefreshingWithNoMoreData ];
            self.shopDetailTableView.mj_footer.backgroundColor = [UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1];
            
        }
        else{
            [self.shopDetailTableView.mj_footer endRefreshing];
        }
        
    } WithFailureBlock:^{
        UILabel *faileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
        faileLable.text = @"哎呀！网络开小差了 T^T";
        faileLable.textColor = [UIColor blackColor];
        faileLable.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        faileLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:faileLable];
        [_shopDetailTableView removeFromSuperview];
    }];
    
}
//设置section的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
        
    }
    else{
        if (_commentArray.count == 0) {
            return 0;
        }
        else{
            return _commentArray.count+1;//由于设置第一行为评论框
        }
    }
}
//设置各个section和row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return MAIN_SCREEN_W/375*250;
        }
        if (indexPath.row == 1|indexPath.row == 2|indexPath.row == 3) {
            return MAIN_SCREEN_W/375*40;
        }
    }
    else if (indexPath.section == 1 ){
        if (indexPath.row == 0) {
            return MAIN_SCREEN_W/375*36;
        }
    }
    return MAIN_SCREEN_W/375*65;
}

//整个店面细节有两个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZJshopTableViewCell *cell = [_shopDetailTableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = (ZJshopTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"ZJshopTableViewCell" owner:self options:nil]lastObject];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        if (indexPath.row == 0) {
            //使用字典数组中的关键字取得
            [cell.shopDetailImage sd_setImageWithURL:[_shopInfo[@"infoData"][@"shop_image"]firstObject]placeholderImage:nil];
            cell.shopDetailText.hidden = YES;
            [cell.shopDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView.mas_top).offset(UIWidth*13);
                make.left.equalTo(cell.contentView.mas_left).offset(UIWidth*13);
                make.bottom.equalTo(cell.contentView.mas_bottom).offset(-UIWidth*20);
                make.right.equalTo(cell.contentView.mas_right).offset(-UIWidth*13);
            }];
            
        }
        if (indexPath.row == 1) {
            cell.shopDetailImage.image = [UIImage imageNamed:@"Address"];
            cell.shopDetailText.text = _shopInfo[@"infoData"][@"shop_address"];
            cell.shopDetailText.font = [UIFont systemFontOfSize:14];
           [ cell.shopDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(cell.mas_top).offset(UIWidth*10);
               make.left.equalTo(cell.mas_left).offset(UIWidth*19);
               make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*10);
               make.right.equalTo(cell.shopDetailText.mas_left).offset(-UIWidth*7);
               make.right.equalTo(cell.mas_right).offset(-UIWidth*339);
           }];
            [cell.shopDetailText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_top).offset(UIWidth*10);
                make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*10);
                make.right.equalTo(cell.mas_right).offset(-UIWidth*10);
            }];
        }
        if (indexPath.row == 2) {
            cell.shopDetailImage.image = [UIImage imageNamed:@"tel"];
            cell.shopDetailText.text = _shopInfo[@"infoData"][@"shop_tel"];
            cell.shopDetailText.font = [UIFont systemFontOfSize:14];
            [cell.shopDetailText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_top).offset(UIWidth*10);
                make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*10);
                make.right.equalTo(cell.mas_right).offset(-UIWidth*10);
            }];
            [cell.shopDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_top).offset(UIWidth*10);
                make.left.equalTo(cell.mas_left).offset(UIWidth*19);
                make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*10);
                make.right.equalTo(cell.shopDetailText.mas_left).offset(-UIWidth*7);
                make.right.equalTo(cell.mas_right).offset(-UIWidth*339);
            }];
            
        }
            if (indexPath.row == 3) {
                cell.shopDetailImage.image = [UIImage imageNamed:@"yuan"];
                cell.shopDetailText.text = @"暂无";
                cell.shopDetailText.font = [UIFont systemFontOfSize:14];
                [cell.shopDetailText mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top).offset(UIWidth*10);
                    make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*10);
                    make.right.equalTo(cell.mas_right).offset(-UIWidth*10);
                }];
                [cell.shopDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top).offset(UIWidth*10);
                    make.left.equalTo(cell.mas_left).offset(UIWidth*19);
                    make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*10);
                    make.right.equalTo(cell.shopDetailText.mas_left).offset(-UIWidth*7);
                    make.right.equalTo(cell.mas_right).offset(-UIWidth*339);
                }];
            }
            return cell;
        
        }
        else{
            if (indexPath.row == 0) {
                ZJshopTableViewCell *cell = [_shopDetailTableView cellForRowAtIndexPath:indexPath];//评论框
                if (cell == nil) {
                    cell = (ZJshopTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"ZJshopTableViewCell" owner:self options:nil]lastObject];
                }
                cell.shopDetailImage.image = [UIImage imageNamed:@"rectangle"];
                cell.shopDetailText.text = @"评论";
                cell.shopDetailText.font = [UIFont systemFontOfSize:14];
                [cell.shopDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top).offset(UIWidth*15);
                    make.left.equalTo(cell.mas_left).offset(UIWidth*18);
                    make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*7);
                    make.right.equalTo(cell.shopDetailText.mas_left).offset(-UIWidth*7);
                    make.right.equalTo(cell.mas_right).offset(-UIWidth*354);
                }];
                [cell.shopDetailText mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top).offset(UIWidth*15);
                    make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*7);
                    make.right.equalTo(cell.mas_right).offset(-UIWidth*10);
                }];
                return cell;
            }
            else{
                NSString *str = @"shopPidOne";//评论框
                
                ZJshopTableViewCell *cell = [_shopDetailTableView dequeueReusableCellWithIdentifier:str];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJshopTableViewCell" owner:self options:nil]firstObject];
                    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                }
                cell.picture.image = [UIImage imageNamed:@"shop_headImage"];
                cell.shopNameLabel.text =_commentArray[indexPath.row-1][@"comment_author_name"];
                cell.shopNameLabel.font = [UIFont systemFontOfSize:15];
                
                cell.shopAddressLabel.text = _commentArray[indexPath.row-1][@"comment_content"];
                cell.shopAddressLabel.font = [UIFont systemFontOfSize:13];
                [cell.picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(cell.mas_top).offset(UIWidth*13);
                    make.left.equalTo(cell.mas_left).offset(UIWidth*17);
                    make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*31);
                    make.right.equalTo(cell.mas_right).offset(-UIWidth*337);
                    make.right.equalTo(cell.shopNameLabel.mas_left).offset(-UIWidth*10);
                    make.right.equalTo(cell.shopAddressLabel.mas_left).offset(-UIWidth*10);
                }];
                [cell.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top).offset(UIWidth*13);
                    make.bottom.equalTo(cell.shopAddressLabel.mas_top).offset(-UIWidth*8);
                    make.right.equalTo(cell.mas_right).offset(-UIWidth*270);
                    make.height.mas_offset(15);
                }];
                [cell.shopAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(cell.mas_bottom).offset(-UIWidth*10);
                    make.right.equalTo(cell.mas_right).offset(-UIWidth*10);
                }];
                
            return cell;
            }
        }
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_shopDetailTableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
