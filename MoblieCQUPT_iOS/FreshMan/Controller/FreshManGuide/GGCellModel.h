//
//  GGCellModel.h
//  GGTableViewCell
//
//  Created by GQuEen on 16/8/13.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface GGCellModel : NSObject

@property (copy, nonatomic) NSString *contentData;

@property (assign, nonatomic) CGFloat normalHeigh;
@property (assign, nonatomic) CGFloat expendHeigh;

@property (assign, nonatomic) CGFloat cellHeigh;

@property (assign ,nonatomic) NSInteger cellType;


- (instancetype)initWithContentData:(NSString *)data;

@end
