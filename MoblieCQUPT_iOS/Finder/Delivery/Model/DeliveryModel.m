//
//  DeliveryModel.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "DeliveryModel.h"

@implementation DeliveryModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.title = dic[@"name"];
        self.content = dic[@"content"];
        self.arr = dic[@"picture"];
        if(_arr != nil && ![_arr isKindOfClass:[NSNull class]] && _arr.count != 0){
            self.imgarr = [self imageWithArray:self.arr];
        }
        else{
            self.imgarr = [self imageArr];
        }
    }
    return self;
}


- (NSMutableArray *)imageArr{
    NSMutableArray *imgArr = [NSMutableArray array];
    UIImage *image = [UIImage imageNamed:@"圆角矩形"];
    [imgArr addObject:image];
    return imgArr;
}

- (NSMutableArray *)imageWithArray:(NSArray *)arr{
    NSMutableArray *imgArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSString *str = [NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",self.arr[i]];
        NSDate *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: str]];
        UIImage *img = [UIImage imageWithData:imageData];
        [imgArr addObject:img];
    }
    return imgArr;
}

+ (instancetype)DeleModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDic:dict];
}

@end
