//
//  StuBedroomViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/4.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <Masonry.h>
#import <AFNetworking.h>
#import "StuBedroomViewController.h"
#import "MyTableViewCell.h"

@interface StuBedroomViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *urlStrArray;
@property (strong, nonatomic) NSMutableArray *descriptionArray;
@property (strong, nonatomic) NSMutableArray *secondNameArray;
@property (strong, nonatomic) NSMutableArray *nameArray;
@property (strong, nonatomic) UIView *blackView;

@property NSInteger tag;
@end

@implementation StuBedroomViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - (SCREENHEIGHT-64)*50/667 - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return _tableView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameArray = [[NSMutableArray alloc] initWithObjects:@"明理苑", @"宁静苑", @"兴业苑", @"知行苑", nil];
    self.secondNameArray = [[NSMutableArray alloc] initWithObjects:@"（原24—31,39栋）", @"（原8—12，32-35栋）", @"（原17-23栋）", @"（原1—6，15,16栋）" , nil];
    self.urlStrArray = [[NSMutableArray alloc] init];;
    for (int i = 0; i < 4; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        self.urlStrArray[i] = array;
    }
    NSLog(@"-----------> %ld", self.urlStrArray.count);
    self.descriptionArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
}

- (void)getData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    [manager GET:@"http://hongyan.cqupt.edu.cn/welcome/2017/api/apiForGuide.php?RequestType=Dormitory" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseobject) {
        NSDictionary *dic = responseobject;
        for (int i = 0; i < self.urlStrArray.count; i++) {
            self.descriptionArray[i] = dic[@"Data"][i][@"resume"];
            for (int j = 0; j < 4; j++) {
                self.urlStrArray[i][j] = dic[@"Data"][i][@"url"][j];
            }
        }
        [self.tableView reloadData];
        
    }failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"请求失败,error:%@", error);
    }];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:self options:nil] lastObject];;
        cell.myImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.myImageView.layer.cornerRadius = 3;
        cell.myImageView.layer.masksToBounds = YES;
        cell.SeparatorView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameLabel.font = [UIFont systemFontOfSize:15];
        
        cell.secondNameLabel.font = [UIFont systemFontOfSize:13];
        cell.secondNameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
          }
    UIView *view = [[UIView alloc] init];
    view.tag = 222;
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    view.layer.cornerRadius = 3;
    [cell.myImageView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.myImageView.mas_right).offset(-10);
        make.bottom.equalTo(cell.myImageView.mas_bottom).offset(-8);
        make.width.mas_equalTo(53);
        make.height.mas_equalTo(19);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addUIscrollView:)];
    [cell.myImageView addGestureRecognizer:tapGesture];
    cell.descriptionLabel.font = [UIFont systemFontOfSize:13];
    cell.descriptionLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
    UILabel *numberOfPhotos = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 28, 19)];
    numberOfPhotos.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    numberOfPhotos.text = @" 4张";
    numberOfPhotos.textColor = [UIColor whiteColor];
    numberOfPhotos.font = [UIFont systemFontOfSize:12];
    [view addSubview:numberOfPhotos];
    
    UIImageView *cameraImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 4, 12, 12)];
    cameraImageView.image = [UIImage imageNamed:@"camera"];
    cameraImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [view addSubview:cameraImageView];
    
    if (self.descriptionArray) {
        cell.nameLabel.text = self.nameArray[indexPath.row];
        cell.secondNameLabel.text = self.secondNameArray[indexPath.row];
        cell.descriptionLabel.text = self.descriptionArray[indexPath.row];
    
        NSString *encodedString = [self.urlStrArray[indexPath.row][0] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        cell.myImageView.userInteractionEnabled = YES;
        cell.myImageView.tag = indexPath.row;

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [cell viewWithTag:222];
    [view removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.descriptionArray) {
        return self.descriptionArray.count;
    }
    else {
        return 4;
    }
}

- (void)addUIscrollView:(UITapGestureRecognizer *)sender{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.blackView = view;
    view.backgroundColor = [UIColor blackColor];
    view.tag = 518;
    

//返回手势
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
    [view addGestureRecognizer:tapToBackGesture];
    
//scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 251)/2.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIScreen mainScreen].bounds.size.height - 251)/2.0)];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, 251);
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 251)];
        imageView.userInteractionEnabled = NO;
        imageView.contentMode = UIViewContentModeScaleToFill;
        NSString *encodedString = [self.urlStrArray[sender.view.tag][i] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:encodedString]];
        [scrollView addSubview:imageView];
    }
    
    [view addSubview:scrollView];
    
//图片页数label
    
    UILabel *numberOfPhotos = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - 20, 31, 40, 20)];
    numberOfPhotos.textColor = [UIColor whiteColor];
    numberOfPhotos.tag = 111;
    numberOfPhotos.font = [UIFont systemFontOfSize:17];
    numberOfPhotos.text = [NSString stringWithFormat:@"1/4"];
    [view addSubview:numberOfPhotos];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int i = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    UILabel *label = [self.blackView viewWithTag:111];
    label.text = [NSString stringWithFormat:@"%d/4", i + 1];
}

- (void)tapToBack {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:518];
    [view removeFromSuperview];
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
