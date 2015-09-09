//
//  ViewController.m
//  EmptyRoomsTest
//
//  Created by RainyTunes on 8/23/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "EmptyRoomsViewController.h"
#import "BFPaperCheckbox.h"
#import "UIColor+BFPaperColors.h"
#import "Config.h"
#define r bfPaperCheckboxDefaultRadius
#define RowSpace (r + 10)
#define fontSize 20

#define x1 ScreenWidth * 0.2
#define x2 ScreenWidth * 0.625
#define y ScreenHeight * 0.55

@interface EmptyRoomsViewController ()
@property (strong,nonatomic)UILabel *results;

@end

@implementation EmptyRoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:COLOR_CONTENTBACKGROUND];
    [self initButtons];
    [self initNavigationBar:@"找空教室"];
    [self initReusltDialog];
}

- (void)initReusltDialog {
    int height = 210;
    if (ScreenHeight <= 480) {
        height = 120;
    }
    self.results = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, [We getScreenWidth], height)];
    [self.results setBackgroundColor:COLOR_CONTENTREGION];
    [self.results setTextAlignment:NSTextAlignmentCenter];
    [self.results setText:bothGroupsUncheckHint];
    self.results.numberOfLines = -1;
    self.results.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.results];
}

- (void)initNavigationBar:(NSString *)title{
    UINavigationBar *navigaionBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    UINavigationItem *navigationItem  = [[UINavigationItem alloc]initWithTitle:nil];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    [navigaionBar pushNavigationItem:navigationItem animated:YES];
    [navigaionBar setBackgroundColor:COLOR_NAVIGATIONBAR];
    [navigaionBar setTintColor:COLOR_NAVIGATIONBAR_TINT];
    
    navigaionBar.layer.shadowColor = [UIColor blackColor].CGColor;
    navigaionBar.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);//有个毛线用啊
    navigaionBar.layer.shadowOpacity = 0.1f;
    navigaionBar.layer.shadowRadius = 1.0f;
    
    [navigationItem setLeftBarButtonItem:leftButton];
    [navigationItem setTitle:title];
    [self.view addSubview:navigaionBar];
}

- (void)initButtons {
    NSArray *buildNameArray    = buildList;
    NSInteger buildTagArray[6] = buildTagList;
    NSArray *periodNameArray   = periodList;
    self.buildCheckboxGroup    = [@[] mutableCopy];
    self.periodCheckboxGroup   = [@[] mutableCopy];
    NSInteger height = y;
    if (screenHeight <= 480) {
        height = height - 40;
    }
    for (int i = 0; i < 6; i++) {
        BFPaperCheckbox *checkBox1 = [self checkBoxWithCenter:CGPointMake(x2, height + 45 * i)];
        [checkBox1 setTag:(NSInteger)buildTagArray[i]];
        [checkBox1 setCheckmarkColor:[UIColor paperColorOrange500]];
        [checkBox1 setTapCirclePositiveColor:[UIColor paperColorOrange200]];
        [checkBox1 setTapCircleNegativeColor:[UIColor paperColorGray300]];
        UILabel *label1 = [self labelWith:CGPointMake(x2 + 70, height + 45 * i) Text:buildNameArray[i]];
        
        BFPaperCheckbox *checkBox2 = [self checkBoxWithCenter:CGPointMake(x1, height + 45 * i)];
        [checkBox2 setCheckmarkColor:[UIColor paperColorOrange500]];
        [checkBox2 setTapCirclePositiveColor:[UIColor paperColorOrange200]];
        [checkBox2 setTapCircleNegativeColor:[UIColor paperColorGray300]];
        [checkBox2 setTag:i];
        UILabel *label2 = [self labelWith:CGPointMake(x1 + 70, height + 45 * i) Text:periodNameArray[i]];
        [self.buildCheckboxGroup addObject:checkBox1];
        [self.periodCheckboxGroup addObject:checkBox2];
        [self.view addSubview:checkBox1];
        [self.view addSubview:checkBox2];
        [self.view addSubview:label1];
        [self.view addSubview:label2];
    }
    [self.buildCheckboxGroup[5] setTag:100];
    [self.periodCheckboxGroup[5] setTag:-100];
    
}

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BFPaperCheckbox *)checkBoxWithCenter:(CGPoint)center{
    BFPaperCheckbox *checkBox = [[BFPaperCheckbox alloc]initWithFrame:CGRectMake(0, 0, 25 * 2, 25 * 2)];
    checkBox.center = center;
    checkBox.delegate = self;
    checkBox.tapCircleNegativeColor = [UIColor paperColorBlue100];
    checkBox.tapCirclePositiveColor = [UIColor paperColorBlue];
    checkBox.checkmarkColor = [UIColor paperColorBlue];
    return checkBox;
}


- (UILabel *)labelWith:(CGPoint)center Text:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.center = center;
    label.textAlignment = NSTextAlignmentLeft;
    [label setText:text];
    label.font = [UIFont fontWithName:@"Heiti TC" size:fontSize];
    return label;
}

- (void)paperCheckboxChangedState:(BFPaperCheckbox *)checkbox
{
    if (self.isChanging || self.lock) {
        return;
    }
    NSInteger tag = checkbox.tag;
    //教室列全开、全关
    if (tag == 100) {
        [self buildGroupAllChange:checkbox.isChecked];
    }
    //时段列全开、全关
    if (tag == -100) {
        [self periodGroupAllChange:checkbox.isChecked];
    }
    [self.results setText:[self.delegate getUserHint]];
}

- (void)buildGroupAllChange:(BOOL)isChecking {
    self.isChanging = YES;
    for (int i = 0; i <= 4; i++) {
        if (isChecking) {
            [self.buildCheckboxGroup[i] checkAnimated:YES];
        } else {
            [self.buildCheckboxGroup[i] uncheckAnimated:YES];
        }
    }
    self.isChanging = NO;
}

- (void)periodGroupAllChange:(BOOL)isChecking {
    self.isChanging = YES;
    for (int i = 0; i <= 4; i++) {
        if (isChecking) {
            [self.periodCheckboxGroup[i] checkAnimated:YES];
        } else {
            [self.periodCheckboxGroup[i] uncheckAnimated:YES];
        }
    }
    self.isChanging = NO;
}
- (NSString *)refreshResult {
    NSMutableArray *availableRooms = [[NSMutableArray alloc]init];
    for (int i = 0; i < 5; i++) {
        BFPaperCheckbox *checkBox = self.buildCheckboxGroup[i];
        if ([checkBox isChecked]) {
            [availableRooms addObjectsFromArray:[self availableRoomsInThisBuild:checkBox.tag]];
        }
    }
    if (availableRooms.count != 0) {
        NSMutableString *newResult = [[NSMutableString alloc]init];
        for (NSString *roomName in availableRooms) {
            [newResult appendString:roomName];
            [newResult appendString:@" "];
        }
            return newResult;
    }else{
        return noResultHint;
    }
}

- (NSArray *)availableRoomsInThisBuild:(NSInteger)tag {
    NSMutableArray *availableRoomsInThisBuildInAllPeriods = [[NSMutableArray alloc]init];
    for (int j = 0; j < 5; j++) {
        BFPaperCheckbox *checkBox2 = self.periodCheckboxGroup[j];
        if ([checkBox2 isChecked]) {
            NSMutableArray *availableRoomsInThisBuildInThisPeriod = [[NSMutableArray alloc]init];
            NSMutableArray *allRoomsInThisBuildInThisPeriod = self.delegate.emptyRoomBundle[j];
            for (NSString *roomName in allRoomsInThisBuildInThisPeriod) {
                if ([roomName characterAtIndex:0] == tag + 48) {
                    [availableRoomsInThisBuildInThisPeriod addObject:roomName];
                }
            }
            [availableRoomsInThisBuildInAllPeriods addObject:availableRoomsInThisBuildInThisPeriod];
        }
    }
    return [We getSameComponents:availableRoomsInThisBuildInAllPeriods];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
