//
//  SYCActivityModel.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCActivityModel : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *detail;
@property (nonatomic, strong)NSMutableArray *imagesArray;

- (instancetype)initWithName:(NSString *)name imageURLs:(NSArray *)imageURLs detail:(NSString *)detail;

@end
