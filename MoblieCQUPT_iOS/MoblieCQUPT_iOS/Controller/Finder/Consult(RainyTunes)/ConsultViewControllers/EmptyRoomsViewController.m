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
#define x1 65
#define y1 300

#define x2 215
#define y2 300

@interface EmptyRoomsViewController ()
@property (strong,nonatomic)NSMutableArray *buildCheckboxGroup, *periodCheckboxGroup;
@property (strong,nonatomic) UILabel *results;

@end

@implementation EmptyRoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initButtons];
    
    self.results = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, [We getScreenWidth] - 40, 160)];
    [self.results setBackgroundColor:[UIColor paperColorGray100]];
    [self.results setBackgroundColor:[We getColor:Orange]];
    [self.results setTextAlignment:NSTextAlignmentCenter];
    [self.results setText:defaultResult];
    self.results.numberOfLines = -1;
    self.results.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.results];
    
}

- (void)initButtons {
    NSArray *buildNameArray    = buildList;
    NSInteger buildTagArray[6] = buildTagList;
    NSArray *periodNameArray   = periodList;
    self.buildCheckboxGroup    = [@[] mutableCopy];
    self.periodCheckboxGroup   = [@[] mutableCopy];
    for (int i = 0; i < 6; i++) {
        BFPaperCheckbox *checkBox1 = [self checkBoxWithCenter:CGPointMake(x1, y1 + 45 * i)];
        [checkBox1 setTag:(NSInteger)buildTagArray[i]];
        UILabel *label1 = [self labelWith:CGPointMake(x1 + 70, y1 + 45 * i) Text:buildNameArray[i]];
        BFPaperCheckbox *checkBox2 = [self checkBoxWithCenter:CGPointMake(x2, y2 + 45 * i)];
        [checkBox2 setTag:i];
        UILabel *label2 = [self labelWith:CGPointMake(x2 + 70, y2 + 45 * i) Text:periodNameArray[i]];
        [self.buildCheckboxGroup addObject:checkBox1];
        [self.periodCheckboxGroup addObject:checkBox2];
        [self.view addSubview:checkBox1];
        [self.view addSubview:checkBox2];
        [self.view addSubview:label1];
        [self.view addSubview:label2];
        
        
        UIButton *backButton = [We getButtonWithTitle:@"返回" Color:Blue];
        [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        backButton.center = CGPointMake(50, 50);
        [self.view addSubview:backButton];
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    label.center = center;
    label.textAlignment = NSTextAlignmentLeft;
    [label setText:text];
    label.font = [UIFont fontWithName:@"Heiti TC" size:fontSize];
    return label;
}

- (void)paperCheckboxChangedState:(BFPaperCheckbox *)checkbox
{
    NSInteger tag = checkbox.tag;
    //教室列全开、全关
    if (tag == 100) {
        for (int i = 0; i <= 4; i++) {
            if (checkbox.isChecked) {
                [self.buildCheckboxGroup[i] checkAnimated:YES];
            } else {
                [self.buildCheckboxGroup[i] uncheckAnimated:YES];
            }
        }
    }
    //时段列全开、全关
    if (tag == -100) {
        for (int i = 0; i < 5; i++) {
            if (checkbox.isChecked) {
                [self.periodCheckboxGroup[i] checkAnimated:YES];
            } else {
                [self.periodCheckboxGroup[i] uncheckAnimated:YES];
            }
        }
    }
    int flag1 = 0;
    int flag2 = 0;
    for (int i = 0; i < 5; i++) {
        if ([self.buildCheckboxGroup[i] isChecked]) {
            flag1 = 1;
        }
        if ([self.periodCheckboxGroup[i] isChecked]) {
            flag2 = 1;
        }
    }
    [self.results setText:[self.delegate getUserHint:flag1 :flag2]];
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
