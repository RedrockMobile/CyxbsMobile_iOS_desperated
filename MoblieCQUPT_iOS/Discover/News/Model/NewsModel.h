//
//  NewsModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/9/28.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject
@property (nonatomic, strong)NSMutableArray *newsArray;
@property (nonatomic, strong)NSDictionary *newsDetailDic;
- (void)getNewsList:(NSString *)pageNum;
- (void)getNewsDetail:(NSString *)newsId;

@end

NS_ASSUME_NONNULL_END
