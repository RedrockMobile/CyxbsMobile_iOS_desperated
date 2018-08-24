//
//  BusTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "BusTableViewCell.h"
#import "BusModel.h"
#import "autoScrollView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667

@interface BusTableViewCell()<autoScrollViewDelegate>

@end

@implementation BusTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier: reuseIdentifier]){
        self.ScrollIndex = 1;
        
        self.bkgImg = [[UIImageView alloc] initWithFrame:CGRectMake(15*WIDTH, 15*HEIGHT,346*WIDTH,237*HEIGHT)];
        self.bkgImg.image = [UIImage imageNamed:@"圆角矩形"];
        self.bkgImg.layer.shadowColor = [UIColor blackColor].CGColor;
        self.bkgImg.layer.shadowOffset = CGSizeMake(0, 0);
        self.bkgImg.layer.shadowOpacity = 0.05;
        self.bkgImg.layer.shadowRadius = 4.5;
        [self.contentView addSubview:self.bkgImg];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH, 213*HEIGHT, 316*WIDTH, 14*HEIGHT)];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        [self.contentView addSubview:self.titleLabel];
        
        self.ContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH, 237*HEIGHT, 316*WIDTH, 0)];
        self.ContentLabel.font = [UIFont systemFontOfSize:14*HEIGHT];
        self.ContentLabel.numberOfLines = 0;
        self.ContentLabel.textColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.4000 alpha:1.0];
        [self.contentView addSubview:self.ContentLabel];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH, 40*WIDTH, 316*WIDTH, 164*HEIGHT)];
        self.imgView.userInteractionEnabled = YES;
        self.imgView.layer.cornerRadius=10;
        self.imgView.clipsToBounds=YES;
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage)];
        [self.imgView addGestureRecognizer:tapGesture];
//        [self.contentView addSubview:self.imgView];
        self.sdwImg = [[UIImageView alloc] initWithFrame:CGRectMake(29.5*WIDTH, 39.5*HEIGHT, 317*WIDTH, 165*HEIGHT)];
        self.sdwImg.layer.cornerRadius=10;
        self.sdwImg.clipsToBounds=YES;
        self.sdwImg.image = [UIImage imageNamed:@"灰色底板"];
        [self.contentView addSubview:self.sdwImg];

        
        self.imgViews = [[autoScrollView alloc]initWithFrame:CGRectMake(30*WIDTH, 40*HEIGHT, 316*WIDTH, 164*HEIGHT)];
        self.imgViews.delegate = self;
        self.imageView.layer.cornerRadius = 10;
        self.imageView.clipsToBounds = YES;
//        [self.contentView addSubview:self.imgViews];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}


- (void)didClickImage{
    [self.delegate clickAtIndex:_Index andscriollViewIndex: self.ScrollIndex];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Identifier = @"status";
    BusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[BusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (BusTableViewCell *)cell;
}

- (void)setModel:(BusModel *)Model{
    _Model = Model;
    self.titleLabel.text = self.Model.title;
    self.ContentLabel.text = self.Model.content;
    CGFloat height = [BusTableViewCell getStringHeight:Model.content font:14*HEIGHT];
    CGFloat titleH = [BusTableViewCell getStringHeight:Model.title font:14*HEIGHT];
    self.titleLabel.frame = CGRectMake(30*WIDTH, 230*HEIGHT, 316*WIDTH, titleH);
    self.ContentLabel.frame = CGRectMake(30*WIDTH, 232*HEIGHT+titleH, 319*WIDTH, height+titleH);
    self.bkgImg.frame = CGRectMake(15*WIDTH, 15*HEIGHT,346*WIDTH,267*HEIGHT+height+titleH);
    
    if(_Model.arr.count == 1){
        self.imgView.image = _Model.imgArray[0];
        [self.contentView addSubview:self.imgView];
    }
    else{
        NSArray *arr = Model.imgArray;
        NSMutableArray *imgArray = [@[] mutableCopy];
        for (int i = 0; i < arr.count; i++) {
            UIImage *img = arr[i];
            UIImageView *image = [[UIImageView alloc] init];
            image.layer.cornerRadius = 10;
            image.clipsToBounds = YES;
            image.image = img;
            [imgArray addObject:image];
        }
        [self.imgViews setImageViewAry:imgArray];
        [self.contentView addSubview:self.imgViews];
    }
}

+ (CGFloat)getStringHeight:(NSString *)string font:(CGFloat)fontSize {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(319*WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return ceil(rect.size.height);
}

+ (CGFloat)cellHeight:(BusModel *)Model{
    CGFloat height = [BusTableViewCell getStringHeight:Model.title font:14*HEIGHT];
    return [BusTableViewCell getStringHeight:Model.content font:14*HEIGHT]+280*HEIGHT+height;
}

-(void)didClickPage:(autoScrollView *)view atIndex:(NSInteger)index
{
    self.ScrollIndex = index;
    [self.delegate clickAtIndex:_Index andscriollViewIndex:index];
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


