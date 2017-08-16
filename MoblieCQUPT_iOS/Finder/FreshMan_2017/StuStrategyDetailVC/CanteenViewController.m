//
//  CanteenViewController.m
//  TestLayoutButton
//
//  Created by helloworld on 2017/8/4.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "MyTableViewCell.h"
#import "CanteenViewController.h"
@interface CanteenViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *urlStrArray;
@property (strong, nonatomic) NSMutableArray *nameArray;
@property (strong, nonatomic) NSMutableArray *descriptionArray;
@property (strong, nonatomic) UIView *blackView;

@end

@implementation CanteenViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - (SCREENHEIGHT-64)*50/667 - 64) style:UITableViewStylePlain];
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
    
    self.nameArray = [[NSMutableArray alloc] init];
    self.urlStrArray = [[NSMutableArray alloc] init];
    self.descriptionArray = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
}

- (void)getData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    [manager GET:@"http://hongyan.cqupt.edu.cn/welcome/2017/api/apiForGuide.php?RequestType=Canteen" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseobject) {
        NSDictionary *dic = responseobject;
        for (int i = 0; i < [dic[@"Data"] count]; i++) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            self.descriptionArray[i] = dic[@"Data"][i][@"resume"];
            self.nameArray[i] = dic[@"Data"][i][@"name"];
            for (int j = 0; j < [dic[@"Data"][i][@"url"] count]; j++) {
                array[j] = dic[@"Data"][i][@"url"][j];
            }
            [self.urlStrArray addObject:array];
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
        cell.secondNameLabel.hidden = YES;
        cell.SeparatorView.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:242/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameLabel.font = [UIFont systemFontOfSize:15];
        
        cell.secondNameLabel.font = [UIFont systemFontOfSize:13];
        cell.secondNameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        
        cell.descriptionLabel.font = [UIFont systemFontOfSize:13];
        cell.descriptionLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        
        cell.myImageView.contentMode = UIViewContentModeScaleToFill;
        cell.myImageView.userInteractionEnabled = NO;
        cell.myImageView.layer.cornerRadius = 3;
        cell.myImageView.layer.masksToBounds = YES;
        cell.myImageView.userInteractionEnabled = NO;
    }
    if (self.urlStrArray) {
       NSString *encodedString = [self.urlStrArray[indexPath.row][0]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        cell.nameLabel.text = self.nameArray[indexPath.row];
        cell.descriptionLabel.text = self.descriptionArray[indexPath.row];
        [cell.myImageView setImageWithURL:[NSURL URLWithString:encodedString] placeholder:[UIImage imageNamed:@"占位图"]];
        if ([self.urlStrArray[indexPath.row] count] >= 2) {
            cell.myImageView.userInteractionEnabled = YES;
            cell.myImageView.tag = indexPath.row;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addUIScrollView:)];
            [cell.myImageView addGestureRecognizer:tapGesture];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.urlStrArray) {
        return self.urlStrArray.count;
    }
    else {
        return 6;
    }
}

- (void)addUIScrollView:(UIGestureRecognizer *)sender {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    self.blackView = view;
    view.tag = 518;
    view.backgroundColor = [UIColor blackColor];
    self.blackView = view;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    
    
    //返回手势
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
    [view addGestureRecognizer:tapToBackGesture];
    
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 251)/2.0, [UIScreen mainScreen].bounds.size.width, 251)];
    scrollView.tag = sender.view.tag;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    int a[6] = {0,0,3,2,0,0};
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * a[sender.view.tag], 251);
    [view addSubview:scrollView];
    

    for (int i = 0; i < a[sender.view.tag]; i++) {
        NSLog(@"1");
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 251)];
        imageView.userInteractionEnabled = NO;
        imageView.contentMode = UIViewContentModeScaleToFill;
        NSString *encodedString = [self.urlStrArray[sender.view.tag][i] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:encodedString]];
        [scrollView addSubview:imageView];
    }
    
    
    UILabel *numberOfPhotos = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - 20, 31, 40, 20)];
    numberOfPhotos.textColor = [UIColor whiteColor];
    numberOfPhotos.tag = 111;
    numberOfPhotos.font = [UIFont systemFontOfSize:17];
    if (sender.view.tag == 2) {
        numberOfPhotos.text = @"1/3";
    }
    else if (sender.view.tag == 3) {
        numberOfPhotos.text = @"1/2";
    }
    [view addSubview:numberOfPhotos];
}

- (void)tapToBack {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:518];
    [view removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int a[6] = {0,0,3,2,0,0};
    int i = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    UILabel *label = [self.blackView viewWithTag:111];
    label.text = [NSString stringWithFormat:@"%d/%ld", i + 1, (long)a[scrollView.tag]];
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
