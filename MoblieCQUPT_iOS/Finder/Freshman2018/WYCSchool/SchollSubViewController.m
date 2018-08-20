//
//  SchollSubViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/17.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SchollSubViewController.h"
#import "FreshmanModel.h"

#import "SchollGeneralTableViewCell.h"

@interface SchollSubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *constraintView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FreshmanModel *Model;
@property (strong, nonatomic) NSMutableArray *cellHeight;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSArray *urlArray;
@property (nonatomic, strong)NSArray *titleArray;
@end

@implementation SchollSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",self.title);
//    _titleArray = @[@"学生食堂",@"明理苑",@"宁静苑",@"兴业苑",@"知行苑"];
//    _urlArray = @[@"http://47.106.33.112:8080/welcome2018/data/get/byindex?index=学生食堂&pagenum=1&pagesize=8",@"http://47.106.33.112:8080/welcome2018/data/get/sushe?name=明理苑",@"http://47.106.33.112:8080/welcome2018/data/get/sushe?name=宁静苑",@"http://47.106.33.112:8080/welcome2018/data/get/sushe?name=兴业苑",@"http://47.106.33.112:8080/welcome2018/data/get/sushe?name=知行苑"];
//    int i = 0;
//    for (NSString *title in _titleArray) {
//        if ([self.title isEqualToString:title]) {
//            _url = _urlArray[i];
//        }
//        i++;
//    }
    if ([self.title isEqualToString:@"学生食堂"]) {
        _url = @"http://47.106.33.112:8080/welcome2018/data/get/byindex?index=学生食堂&pagenum=1&pagesize=8";
    }

    //设置背景色
    self.view.backgroundColor =  [UIColor colorWithHexString:@"f6f6f6"];
    _topHeight.constant = 0;
   
    _Model = [[FreshmanModel alloc]init];
    [_Model networkLoadData: _url title:self.title ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadFailure)
                                                 name:[NSString stringWithFormat:@"%@DataLoadFailure",self.title] object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadSuccessful)
                                                 name:[NSString stringWithFormat:@"%@DataLoadSuccess",self.title] object:nil];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setUrl:(NSString *)url{
    _url = url;
}
- (void)DataLoadSuccessful {
    _tableView = [self tableView];;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _cellHeight = [[NSMutableArray alloc]init];
    [_tableView reloadData];
}

- (void)DataLoadFailure{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"您的网络不给力!";
    [hud hide:YES afterDelay:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , _constraintView.width, _constraintView.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"SchollGeneralTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"test"];
        
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    NSArray *arr = [_Model.dic objectForKey:@"array"];
     NSLog(@"arr:%lu",(unsigned long)arr.count);
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *cellIdentify = @"SchollGeneralTableViewCell";
    SchollGeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
   
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SchollGeneralTableViewCell" owner:self options:nil]firstObject];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    NSArray *arr = [_Model.dic objectForKey:@"array"];
    [cell initWithDic:arr[indexPath.row]];
    NSLog(@"%f",cell.height);
    [_cellHeight addObject:[NSNumber numberWithFloat:cell.height]];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //SchollGeneralTableViewCell *cell = [[SchollGeneralTableViewCell alloc]init];
    return [_cellHeight[indexPath.row] floatValue];
}

//- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
//    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.RootView.width, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
//                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
//    return rect.size.height;
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
