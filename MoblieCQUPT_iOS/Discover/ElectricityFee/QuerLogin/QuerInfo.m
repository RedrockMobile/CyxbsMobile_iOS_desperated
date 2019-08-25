//
//  QuerInfo.m
//  Query
//
//  Created by hzl on 2017/3/16.
//  Copyright © 2017年 c. All rights reserved.
//

#import "QuerInfo.h"
#import <Masonry.h>
#import "QuerCircleView.h"
#define font(R) (R)*([UIScreen mainScreen].bounds.size.width)/375.0
#define NUMBERSOFDATALUMP 5

@implementation QuerInfo

- (void)drawRect:(CGRect)rect {
    self.contentSize =  CGSizeMake(0,self.bounds.size.height/2.5*(int)(NUMBERSOFDATALUMP/2.0+0.5));//scrollView的宽高

    [self drawDataLump];


}




-(void)drawDataLump{
    for (int i = 1; i <= NUMBERSOFDATALUMP; i++) {
        UIImageView *dataLumpView= [[UIImageView alloc]init];
        dataLumpView.backgroundColor = [UIColor whiteColor];
        [self addSubview:dataLumpView];
        [dataLumpView setWidth:0.45*self.bounds.size.width];
        [dataLumpView setHeight:0.28*self.bounds.size.height];
        [dataLumpView setCenter:CGPointMake(i%2==1?self.bounds.size.width/4.0:self.bounds.size.width*3/4.0, i%2==1? self.bounds.size.height*i/5.0:self.bounds.size.height*(i-1)/5.0)];
        NSString*imageName = [NSString stringWithFormat:@"electricity_charge_ic_%d",i];
        dataLumpView.layer.cornerRadius = 5;
        dataLumpView.layer.masksToBounds = YES;
        UIImage*image = [UIImage imageNamed:imageName];
        UIImageView*imageView = [[UIImageView alloc]initWithImage:image];
        [imageView setImage:image];
        imageView.width = 0.9*dataLumpView.width/3+12;
        imageView.height = 0.9*dataLumpView.width/3+12;
//        imageView.backgroundColor = [UIColor yellowColor];
        imageView.center = CGPointMake(dataLumpView.width/6.0+10, dataLumpView.height/2.0);
        imageView.contentMode = UIViewContentModeScaleToFill;
//        imageView.backgroundColor = [UIColor redColor];
        [dataLumpView addSubview:imageView];
        NSArray<NSString*>*labelArray = [NSArray arrayWithObjects:@"费用/本月",@"日均量/度",@"电起度/度",@"电止度/度",@"月优惠量/度", nil];
        UILabel*label = [[UILabel alloc]init];
        [dataLumpView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.centerY.equalTo(dataLumpView).offset(-15);
            make.width.equalTo(@70);
            make.height.equalTo(@20);
        }];
        label.backgroundColor = [UIColor clearColor];
        label.text = labelArray[i-1];
        label.font = [UIFont systemFontOfSize:12.5];
        label.textColor = COLOR_BULE1;
        NSArray<NSString*>*dataLabelArray = [NSArray arrayWithObjects:@"0",self.AveragELecStr,self.ElcStarStr,self.ElcEndStr
                                             ,self.FreeElecStr, nil];
        UILabel*dataLabel = [[UILabel alloc]init];
        [dataLumpView addSubview:dataLabel];
        [dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.centerY.equalTo(dataLumpView).offset(+12);
            make.width.equalTo(@80);
            make.height.equalTo(@30);
        }];
        dataLabel.text = dataLabelArray[i-1];
        dataLabel.font = [UIFont systemFontOfSize:25];
        dataLabel.textColor = COLOR_BULE1;
        
        
    }
}
@end
