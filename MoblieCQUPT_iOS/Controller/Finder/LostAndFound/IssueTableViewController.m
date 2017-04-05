//
//  IssueTableViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "IssueTableViewController.h"
#import "IconTableViewCell.h"
#import <Masonry.h>
#import "LostAndFoundButton.h"
#import "CategoryChooseView.h"
#import "CoverView.h"
#import "LZDatePicker.h"
#import "LostModel.h"
#import "HttpClient.h"
#import "LZConfirmButton.h"
#import "LZLostRemindView.h"
#import "LZIssueSucceedViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface IssueTableViewController ()<LZDatePickerDelegate,UITextViewDelegate,UITextFieldDelegate>
@property NSMutableArray *imageArray;
@property LostAndFoundButton *lostBtn;
@property LostAndFoundButton *foundBtn;
@property CategoryChooseView *categoryChooseView;
@property CoverView *coverView;
@property LZDatePicker *datePicker;
//@property BOOL isShowPicker;
//@property BOOL isShowChooseView;
@property LostModel *model;
@property NSArray *titleArray;
@property UITextView *descriptionTextView;
@property LZLostRemindView *remindView;
@property NSMutableArray <UITextField *>*textFieldArray;
@end

@implementation IssueTableViewController
- (void)viewDidLayoutSubviews{
    self.foundBtn.layer.cornerRadius = self.foundBtn.frame.size.width/2;
    self.lostBtn.layer.cornerRadius = self.lostBtn.frame.size.width/2;
    self.foundBtn.layer.masksToBounds = YES;
    self.lostBtn.layer.masksToBounds = YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    if (self.datePicker.hidden == NO) {
        [self timeChooseAnimated];

    }
    if (self.categoryChooseView.hidden == NO) {
        [self categoryChooseAnimated];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息发布";
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"";
    self.navigationItem.backBarButtonItem = backItem;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.model = [[LostModel alloc]init];
    self.model.pickTime = [formatter stringFromDate:[NSDate date]];
    self.textFieldArray = [NSMutableArray arrayWithCapacity:3];
    self.titleArray = @[@"信息分类",@"物品分类",@"描        述",@"时        间",@"地        点",@"电        话",@"Q         Q"];
    self.imageArray = [NSMutableArray array];
    self.descriptionTextView = [[UITextView alloc] init];
    NSArray *imageNameArray = @[@"lost_image_infocategory",@"lost_image_itemcategory",@"lost_image_describe",@"lost_image_time",@"lost_image_place",@"lost_image_tel",@"lost_image_QQ"];
    for (int i = 0; i<imageNameArray.count; i++) {
        [self.imageArray addObject:[UIImage imageNamed:imageNameArray[i]]];
    }
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    self.coverView = [[CoverView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    __weak IssueTableViewController *weakSelf = self;
    self.coverView.passTap = ^(NSSet *touches,UIEvent *event){
        [weakSelf touchesBegan:touches withEvent:event];
    };
    
    self.categoryChooseView = [[CategoryChooseView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT/2, SCREENWIDTH, SCREENHEIGHT/2)];
    for (int i = 0; i<self.categoryChooseView.btnArray.count; i++) {
        [self.categoryChooseView.btnArray[i] addTarget:self action:@selector(chooseCategory:) forControlEvents:UIControlEventTouchUpInside];
    }

    CGRect frame = self.categoryChooseView.frame;
    frame.origin.y = SCREENHEIGHT;
    frame.size.height = 1;
    self.categoryChooseView.frame = frame;
    self.categoryChooseView.hidden = YES;
    
    self.datePicker = [[LZDatePicker alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT/2, SCREENWIDTH, SCREENHEIGHT/2)];
    self.datePicker.backgroundColor = [UIColor colorWithHexString:@"#fbfbfb"];
    CGRect pickerFrame = self.datePicker.frame;
    pickerFrame.origin.y = SCREENHEIGHT;
    pickerFrame.size.height = 1;
    self.datePicker.frame = pickerFrame;
    self.datePicker.hidden = YES;
    self.datePicker.delegate = self;
    
 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)timeChooseAnimated{
    if (self.datePicker.hidden == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.datePicker.frame;
            frame.origin.y = SCREENHEIGHT;
            frame.size.height = 1;
            self.datePicker.frame = frame;
        }completion:^(BOOL finished) {
            self.datePicker.hidden = YES;
            [self.datePicker removeFromSuperview];
            [self.coverView removeFromSuperview];
        }];
    }
    else{
        [self.view.window addSubview:self.coverView];
        [self.view.window addSubview:self.datePicker];
        self.datePicker.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.datePicker.frame = CGRectMake(0, SCREENHEIGHT/2, SCREENWIDTH, SCREENHEIGHT/2);
        }completion:^(BOOL finished) {
            
        }];
    }
}
- (void)categoryChooseAnimated{
    if (self.categoryChooseView.hidden == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.categoryChooseView.frame;
            frame.origin.y = SCREENHEIGHT;
            frame.size.height = 1;
            self.categoryChooseView.frame = frame;
        }completion:^(BOOL finished) {
            self.categoryChooseView.hidden = YES;
            [self.categoryChooseView removeFromSuperview];
            [self.coverView removeFromSuperview];
        }];
    }
    else{
        [self.view.window addSubview:self.coverView];
        [self.view.window addSubview:self.categoryChooseView];
        self.categoryChooseView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.categoryChooseView.frame = CGRectMake(0, SCREENHEIGHT/12*6.f, SCREENWIDTH, SCREENHEIGHT/12*6);
        }completion:^(BOOL finished) {
            
        }];
    }
}

- (void)chooseCategory:(TickButton *)btn{
    [self categoryChooseAnimated];
    self.model.category = btn.currentTitle;
    [self.tableView reloadData];
}

- (void)click:(LostAndFoundButton *)btn{
    if ([btn.currentTitle isEqualToString:@"寻物"]) {
        self.foundBtn.selected = !btn.selected;
    }
    else{
        self.lostBtn.selected = !btn.selected;
    }
}

- (void)touchBtn:(UIButton *)btn{
    [self timeChooseAnimated];
    if ([btn.currentTitle isEqualToString:@"确定"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        self.model.pickTime = [formatter stringFromDate:self.datePicker.date];
    }
    [self.tableView reloadData];
}

- (void)issueInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.model.stu_num = [defaults objectForKey:@"stuNum"];
    self.model.idNum = [defaults objectForKey:@"idNum"];
    if (self.lostBtn.isSelected) {
        self.model.property = @"寻物启事";
    }
    else{
        self.model.property = @"失物招领";
    }
    self.model.detail = self.descriptionTextView.text;
    self.model.place = self.textFieldArray[0].text;
    self.model.phone = self.textFieldArray[1].text;
    self.model.qq = self.textFieldArray[2].text;
    self.remindView = [[LZLostRemindView alloc]init];
    [self.remindView.btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    BOOL isLackInfo = NO;
    if ([self.model.category isEqualToString:@""]) {
        self.remindView.imageView.image = [UIImage imageNamed:@"lost_image_lackcate"];
        self.remindView.label.text = @"请选择分类";
        isLackInfo = YES;
    }
    if (self.model.detail.length<10){
        self.remindView.imageView.image = [UIImage imageNamed:@"lost_image_little"];
        self.remindView.label.text = @"描述内容不足 请补充";
        isLackInfo = YES;
    }
    if (self.model.detail.length>100) {
        self.remindView.imageView.image = [UIImage imageNamed:@"lost_image_many"];
        self.remindView.label.text = @"描述内容过多 请删减";
        isLackInfo = YES;
    }
    if ([self.model.place isEqualToString:@""]) {
        self.remindView.imageView.image = [UIImage imageNamed:@"lost_image_lackplace"];
        self.remindView.label.text = @"请写明失物地点";
        isLackInfo = YES;
    }
    if ([self.model.phone isEqualToString:@""]) {
        self.remindView.imageView.image = [UIImage imageNamed:@"lost_image_lacktel"];
        self.remindView.label.text = @"请留下您的联系方式";
        isLackInfo = YES;
    }
    if (isLackInfo) {
        [self.view.window addSubview:self.coverView];
        [self.view.window addSubview:self.remindView];
        UIEdgeInsets padding = UIEdgeInsetsMake(0.25*self.view.height, 0.13*self.view.width, self.view.height*0.25, 0.13*self.view.width);
        [self.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(padding);
        }];
        return;
    }
    
    NSDictionary *parameters = [self.model packToParamtersDic];
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:@"http://hongyan.cqupt.edu.cn/laf/api/create" method:HttpRequestPost parameters:parameters prepareExecute:^{
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        LZIssueSucceedViewController *vc = [[LZIssueSucceedViewController alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide:YES afterDelay:1];
        NSLog(@"%@",error);
    }];
}

- (void)confirm{
    [self.coverView removeFromSuperview];
    [self.remindView removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    IconTableViewCell *cell = [[IconTableViewCell alloc]init];
    if (index<7) {
        if(index<4){
            cell = [[NSBundle mainBundle]loadNibNamed:@"IconTableViewCell" owner:self options:nil][1];
            if (index==0) {
                [cell.contentLabel removeFromSuperview];
                self.lostBtn = [[LostAndFoundButton alloc]init];
                [self.lostBtn setTitle:@"寻物" forState:UIControlStateNormal];
                self.foundBtn = [[LostAndFoundButton alloc]init];
                [self.foundBtn setTitle:@"招领" forState:UIControlStateNormal];
                [cell addSubview:self.lostBtn];
                [cell addSubview:self.foundBtn];
                [self.foundBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [self.lostBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                self.lostBtn.selected = YES;
                [self.foundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell).offset(-16);
                    make.top.equalTo(cell).offset(8);
                    make.bottom.equalTo(cell).offset(-8);
                    make.width.equalTo(self.foundBtn.mas_height);
                }];
                [self.lostBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.equalTo(self.foundBtn);
                    make.centerY.equalTo(self.foundBtn.mas_centerY);
                    make.right.equalTo(self.foundBtn.mas_left).with.offset(-10);
                }];
            }
            if(index == 1){
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.contentLabel.text = self.model.category;
            }
            if (index == 3) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.contentLabel.text = self.model.pickTime;
            }
            if (index==2) {
                [cell addSubview:self.descriptionTextView];
                self.descriptionTextView.delegate = self;
                [self.descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentLabel.mas_bottom).offset(10);
                    make.bottom.equalTo(cell.mas_bottom).offset(-20);
                    make.left.equalTo(cell.titleLabel.mas_right).offset(15);
                    make.right.equalTo(cell.mas_right).offset(-16);
                }];
                cell.contentLabel.text = @"请输入10-100字物品描述";
            }
        }
        if(index>=4 && index<7){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"IconTableViewCell" owner:self options:nil] lastObject];
            if (self.textFieldArray.count == 3) {
                cell.contentTextField.text = self.textFieldArray[index-4].text;
            }
            else{
                cell.contentTextField.text = @"";
            }
            self.textFieldArray[index-4] = cell.contentTextField;
            cell.contentTextField.delegate = self;
        }
        cell.iconImageView.image = self.imageArray[index];
        cell.titleLabel.text = self.titleArray[index];
    }
    else {
        LZConfirmButton *btn = [[LZConfirmButton alloc]init];
        [btn addTarget:self action:@selector(issueInfo) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"发布信息" forState:UIControlStateNormal];
        [cell addSubview:btn];
        UIEdgeInsets padding = UIEdgeInsetsMake(16, 16, 16, 16);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell).with.insets(padding);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==2){
        return 186;
    }
    if (indexPath.row == 7) {
        return 72;
    }
    return 57;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    [self.view endEditing:YES];
    if (index==1){
        [self categoryChooseAnimated];
    }
    if (index==3) {
        [self timeChooseAnimated];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
