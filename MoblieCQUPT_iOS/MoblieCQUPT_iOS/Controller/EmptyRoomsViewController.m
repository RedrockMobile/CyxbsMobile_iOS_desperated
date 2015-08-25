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
#import "We.h"
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
    [self.results setTextAlignment:NSTextAlignmentCenter];
    [self.results setText:@"请选择教室与时段"];
    self.results.numberOfLines = -1;
    [self.view addSubview:self.results];
    
}

- (void)initButtons {
    NSArray *buildNameArray    = @[@"二教", @"三教", @"四教", @"五教", @"八教", @"任意教室"];
    NSInteger buildTagArray[6] = {2,3,4,5,8,0};
    NSArray *periodNameArray   = @[@"一二节", @"三四节", @"五六节", @"七八节", @"九十节", @"全部时段"];
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
    [self.results setText:[self refreshResult]];
}

- (NSString *)refreshResult {
    NSMutableArray *availableRooms = [[NSMutableArray alloc]init];
    for (int i = 0; i < 5; i++) {
        BFPaperCheckbox *checkBox = self.buildCheckboxGroup[i];
        if ([checkBox isChecked]) {
            [availableRooms addObjectsFromArray:[self availableRoomsInThisBuild:checkBox.tag]];
        }
    }
    //qlog(availableRooms);
    if (availableRooms.count != 0) {
        NSMutableString *newResult = [[NSMutableString alloc]init];
        for (NSString *roomName in availableRooms) {
            [newResult appendString:roomName];
            [newResult appendString:@" "];
        }
            return newResult;
    }else{
        return @"似乎没有合适的教室哦~";
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
