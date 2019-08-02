//
//  LZNoCourseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/21.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZNoCourseViewController.h"
#import "LZSearchView.h"
#import "CoverView.h"
#import "LZPersonModel.h"
#import "LZPersonSelectViewController.h"
#import "LZPersonAddView.h"
#import "LZNoCourseDateDetailViewController.h"
#import "MyInfoModel.h"

@interface LZNoCourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LZSearchView *searchView;
@property (nonatomic, strong) UIButton *queryBtn;
@property (nonatomic, strong) CoverView *coverView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSMutableArray<LZPersonModel *> *personArray;


@end

@implementation LZNoCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    self.personArray = [NSMutableArray array];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.queryBtn];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT/2);
    }];
    [self.queryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(20);
        make.height.mas_equalTo(self.view.height*0.075);
    }];
    MyInfoModel *myInfo = [MyInfoModel getMyInfo];
    if (myInfo) {
        LZPersonModel *person = [[LZPersonModel alloc]initWithMyInfo:myInfo];
        if(person.name){
            [self.personArray addObject:person];
        }
        // 因为之前没有将名字存在本地，所以加层判断 避免崩溃
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 15);
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-40-3*15)/4, (SCREEN_WIDTH-40-3*15)/6);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UIButton *)queryBtn{
    if (_queryBtn == nil) {
        _queryBtn = [[UIButton alloc]init];
        [_queryBtn setTitle:@"查询" forState:UIControlStateNormal];
        [_queryBtn setBackgroundImage:[UIImage imageNamed:@"all_image_background"] forState:UIControlStateNormal];
        [_queryBtn addTarget:self action:@selector(query) forControlEvents:UIControlEventTouchUpInside];
        _queryBtn.layer.cornerRadius = 2;
        _queryBtn.layer.masksToBounds = YES;
    }
    return _queryBtn;
}

- (CoverView *)coverView{
    if (_coverView == nil) {
        _coverView = [[CoverView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        __weak typeof(self) weakSelf = self;
        _coverView.passTap = ^(NSSet<UITouch *> *touches, UIEvent *event) {
            [weakSelf touchesBegan:touches withEvent:event];
        };
    }
    return _coverView;
}

- (LZSearchView *)searchView{
    if (_searchView == nil) {
        _searchView = [[LZSearchView alloc]init];
        //        _searchView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        _searchView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        _searchView.alpha = 1;
        _searchView.placeHolder = @"请输入要查询的学号/姓名";
        _searchView.cancelBtnTextColor = [UIColor colorWithHexString:@"#999999"];
        _searchView.addBtnTextColor = [UIColor colorWithHexString:@"#788efa"];
        __weak typeof(self) weakSelf = self;
        _searchView.cancelBlock = ^{
            [weakSelf.coverView removeFromSuperview];
            [weakSelf.searchView removeFromSuperview];
        };
        _searchView.addBlock = ^{
            [weakSelf loadPersonInfo];
        };
    }
    return _searchView;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.personArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        [view removeAllSubviews];
    }
    if (indexPath.row == self.personArray.count) {
        LZPersonAddView *addView = [[LZPersonAddView alloc]initWithFrame:cell.bounds type:LZPersonAdd];
        addView.clickBlock = ^{
            [self addAction];
        };
        [cell addSubview:addView];
    }
    else{
        LZPersonAddView *addView = [[LZPersonAddView alloc]initWithFrame:cell.bounds];
        addView.title = self.personArray[indexPath.row].name;
        addView.cancelBlock = ^{
            [self.personArray removeObjectAtIndex:indexPath.row];
            [self.collectionView reloadData];
        };
        [cell addSubview:addView];
    }
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

- (void)query{
    LZNoCourseDateDetailViewController *vc = [[LZNoCourseDateDetailViewController alloc]initWithPersons:self.personArray];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addAction{
    if(self.personArray.count >= 12){
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"人数超过限制";
        [self.hud hide:YES afterDelay:1];
        return;
    }
    
    [self.view.window addSubview:self.coverView];
    [self.view.window addSubview:self.searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo((SCREEN_HEIGHT-HEADERHEIGHT)*0.26);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

- (void)loadPersonInfo{
    [self.searchView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *parameters = @{@"stu":self.searchView.text};
    [client requestWithPath:SEARCHPEOPLEAPI method:HttpRequestGet parameters:parameters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
     
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"status"] isEqualToNumber:@200]) {
            NSArray *personArray = responseObject[@"data"];
            NSMutableArray *persons = [NSMutableArray array];
            for (NSDictionary *person in personArray) {
                LZPersonModel *model = [[LZPersonModel alloc]initWithData:person];
                [persons addObject:model];
            }
            if (persons.count == 1) {
                LZPersonModel *model = [persons firstObject];
                [self addPerson:model];
            }
            else{
                LZPersonSelectViewController *vc = [[LZPersonSelectViewController alloc]initWithPersons:persons];
                vc.selectPersonBlock = ^(LZPersonModel *model) {
                    [self addPerson:model];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else{
            self.hud.mode = MBProgressHUDModeText;
            self.hud.labelText = @"查无此人/输入错误";
            [self.hud hide:YES afterDelay:1];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"网络错误";
        [self.hud hide:YES afterDelay:1];
    }];
}

- (void)addPerson:(LZPersonModel *)person{
    if ([self isRepeatAddPerson:person]) {
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"请勿重复添加";
        [self.hud hide:YES afterDelay:1];
    }
    else{
        [self.personArray addObject:person];
        [self.hud hide:YES];
        [self.collectionView reloadData];
    }
}

- (BOOL)isRepeatAddPerson:(LZPersonModel *)person{
    for (LZPersonModel *oldModel in self.personArray) {
        if ([person.stuNum isEqualToString: oldModel.stuNum]) {
            return YES;
        }
    }
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchView touchesBegan:touches withEvent:event];
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
