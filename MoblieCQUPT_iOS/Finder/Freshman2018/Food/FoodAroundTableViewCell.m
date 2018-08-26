//
//  FoodAroundTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by 陈大炮 on 2018/8/26.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "FoodAroundTableViewCell.h"
#import "FoodAroundModel.h"
#import "autoScrollView.h"
#import "FoodAroundViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width/375
#define HEIGHT [UIScreen mainScreen].bounds.size.height/667


@interface FoodAroundTableViewCell()<autoScrollViewDelegate>

@end


@implementation FoodAroundTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier: reuseIdentifier]){
        

        
        self.ScrollIndex = 1;
        
        self.bkgImg = [[UIImageView alloc] initWithFrame:CGRectMake(15*WIDTH, 15*HEIGHT,346*WIDTH,237*HEIGHT)];
        self.bkgImg.image = [UIImage imageNamed:@"圆角矩形"];
        [self.contentView addSubview:self.bkgImg];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH, 213*HEIGHT, 316*WIDTH, 14*HEIGHT)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        
       
        
        self.priceLabel= [[UILabel alloc]init];
        self.priceLabel.frame = CGRectMake(279 * WIDTH, 199 * WIDTH, 30, 12 * WIDTH);

          self.priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:121/255.0 blue:121/255.0 alpha:1];
        
        [self.contentView addSubview:self.priceLabel];
       
        
        self.ContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH, 237*HEIGHT, 316*WIDTH, 0)];
        self.ContentLabel.font = [UIFont systemFontOfSize:14];
        self.ContentLabel.numberOfLines = 0;
        self.ContentLabel.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
        [self.contentView addSubview:self.ContentLabel];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH, 30*WIDTH, 316*WIDTH, 164*HEIGHT)];
        self.imgView.userInteractionEnabled = YES;
        self.imgView.layer.cornerRadius=10;
        self.imgView.clipsToBounds=YES;
//        [self.contentView addSubview:self.rankButton];

        self.rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rankButton.frame = CGRectMake(281 * WIDTH, 16 * WIDTH, 23 * WIDTH, 41 * WIDTH);
        [self.rankButton setImage:[UIImage imageNamed:@"rank.png"] forState:UIControlStateNormal];
        [self.contentView bringSubviewToFront:self.rankButton];
        
       
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage)];
        [self.imgView addGestureRecognizer:tapGesture];
        //        [self.contentView addSubview:self.imgView];
        
        self.imgViews = [[autoScrollView alloc]initWithFrame:CGRectMake(30*WIDTH, 30*HEIGHT, 316*WIDTH, 164*HEIGHT)];
        self.imgViews.delegate = self;
        self.imgView.layer.cornerRadius = 10;
        self.imgView.clipsToBounds = YES;
//                [self.contentView addSubview:self.imgViews];
    
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}


- (void)didClickImage{
    [self.delegate clickAtIndex:_Index andscriollViewIndex: self.ScrollIndex];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *Identifier = @"cellFood";
    FoodAroundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
          cell = [[FoodAroundTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (FoodAroundTableViewCell *)cell;
}

- (void)setModel:(FoodAroundModel *)Model{
    _Model = Model;
    self.titleLabel.text = self.Model.title;
    self.ContentLabel.text = self.Model.content;
    CGFloat height = [FoodAroundTableViewCell getStringHeight:Model.content font:15];
    self.ContentLabel.frame = CGRectMake(30*WIDTH, 237*HEIGHT, 319*WIDTH, height);
    self.bkgImg.frame = CGRectMake(15*WIDTH, 15*HEIGHT,346*WIDTH,237*HEIGHT+height);
//    self.rankButton.currentBackgroundImage = [UIImage imageNamed:@"rank.png"];
    
    
    
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
+ (CGFloat)cellHeight:(FoodAroundModel *)Model{
    return [FoodAroundTableViewCell getStringHeight:Model.content font:14]+237*HEIGHT;
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
