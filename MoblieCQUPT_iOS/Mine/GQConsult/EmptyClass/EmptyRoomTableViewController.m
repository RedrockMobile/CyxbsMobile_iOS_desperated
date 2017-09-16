//
//  EmptyRoomTableViewController.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/10.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "EmptyRoomTableViewController.h"

@interface EmptyRoomTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIImageView *pointImageView;
//@property (strong, nonatomic) UILabel *floorLabel;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UITableView *emptyRoomTableView;

@property (strong, nonatomic) NSArray *floorArray;
@property (strong, nonatomic) NSArray *pointArray;
@end

@implementation EmptyRoomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _emptyRoomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    //数据
    _emptyRoomTableView.backgroundColor = [UIColor whiteColor];
    _emptyRoomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _floorArray = @[@"一楼", @"二楼", @"三楼", @"四楼", @"五楼"];
    _pointArray = @[@"pinkPoint", @"bluePoint", @"yellowPoint"];
    _emptyRoomTableView.delegate = self;
    _emptyRoomTableView.dataSource = self;
    [self.view addSubview:_emptyRoomTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *numberOfRoom = _EmptyData[[NSString stringWithFormat:@"%ld",(long)indexPath.row + 1]];
    return 45 + numberOfRoom.count / 5 * 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifler = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifler];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifler];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _pointImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_pointArray[indexPath.row % 3]]];
    _pointImageView.frame = CGRectMake(10, cell.centerY - 5, 10, 10);
    [cell.contentView addSubview:_pointImageView];
    
    
    _topView = [[UIView alloc]init];
    _topView.frame = CGRectMake(_pointImageView.centerX - 1, 0, 2, cell.height / 2 - 5);
    _bottomView = [[UIView alloc]init];
    _bottomView.frame = CGRectMake(_pointImageView.centerX - 1, cell.height / 2 + 5, 2, cell.height / 2 - 5);
    if (indexPath.row == 0) {
        _topView.backgroundColor = [UIColor clearColor];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
        
    }
    else if (indexPath.row == _EmptyData.count){
        _topView.backgroundColor = [UIColor clearColor];
        _topView.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    }
    else{
        _topView.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"E9E9E9"];
    }
    [cell.contentView addSubview:_topView];
    [cell.contentView addSubview:_bottomView];
    UILabel *floorNameLabel = [[UILabel alloc]init];
    floorNameLabel.text = _floorArray[indexPath.row];
    floorNameLabel.textColor = kDetailTextColor;
    floorNameLabel.font = kFont;
    [floorNameLabel sizeToFit];
    floorNameLabel.frame = CGRectMake(40, cell.centerY, 30, 13);
    [cell.contentView addSubview:floorNameLabel];
    
    int j = 0;
    for (NSString *thing in _EmptyData[[NSString stringWithFormat:@"%ld",(long)indexPath.row + 1]]) {
        UILabel *floorLabel = [[UILabel alloc]init];
        floorLabel.textColor = kDetailTextColor;
        floorLabel.font = kFont;
        floorLabel.text = thing;
        [floorLabel sizeToFit];
        floorLabel.frame = CGRectMake(floorNameLabel.centerX + 35 + (j % 5) * 45, 15 + (j / 5) * 16, 33, 11);
        [cell.contentView addSubview:floorLabel];
        j ++;
    }
    
    
    return cell;
}
@end
