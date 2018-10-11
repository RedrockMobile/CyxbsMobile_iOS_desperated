//
//  LZCarouselModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/10/9.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZCarouselModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *picture_url;
@property (nonatomic, copy) NSString *picture_goto_url;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) UIImage *picture;
@property (nonatomic, strong) NSData *imageData;

- (instancetype)initWithData:(NSDictionary *)data;

@end
