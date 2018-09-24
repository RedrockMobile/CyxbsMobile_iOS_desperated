//
//  WYCShowDetailViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/9/24.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WYCShowDetailViewController.h"
#import "WYCShowDetailView.h"
#import "DLChooseClassListViewController.h"
#import "AddRemindViewController.h"
#import "WYCNoteModel.h"
@interface WYCShowDetailViewController ()
@property(nonatomic, strong) WYCShowDetailView *detailClassBookView;

@end

@implementation WYCShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"详细信息";

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showStuList)
                                                 name:@"showStuList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editNote)
                                                 name:@"editNote" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deleteNote)
                                                 name:@"deleteNote" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NoteDeleteSuccess)
                                                 name:@"NoteDeleteSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NoteDeleteFailure)
                                                 name:@"NoteDeleteFailure" object:nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)initWithArray:(NSArray *)array{
   
    //vc.view.backgroundColor = [UIColor greenColor];
    self.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-(HEADERHEIGHT+TABBARHEIGHT));
    [self.view layoutIfNeeded];
    self.detailClassBookView  = [[WYCShowDetailView alloc]initWithFrame:self.view.frame];
    [self.detailClassBookView initViewWithArray:array];
 
    [self.view addSubview:self.detailClassBookView];
}


- (void)showStuList{
    DLChooseClassListViewController *vc = [[DLChooseClassListViewController alloc]init];
    [vc initWithClassNum:self.detailClassBookView.classNum];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editNote{
    AddRemindViewController *vc = [[AddRemindViewController alloc]initWithRemind:self.detailClassBookView.remind];
   // [vc initWithRemind:self.detailClassBookView.remind];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)deleteNote{
    NSNumber *noteId = [self.detailClassBookView.remind objectForKey:@"id"];
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    WYCNoteModel *model = [[WYCNoteModel alloc]init];
    [model deleteNote:stuNum idNum:idNum noteId:noteId];
}
-(void)NoteDeleteSuccess{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)NoteDeleteFailure{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"网络错误" message:@"备忘删除失败" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act1=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [controller addAction:act1];
    
    [self presentViewController:controller animated:YES completion:^{
        
    }];
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
