//
//  MBCommunityNetWorking.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityNetWorking.h"
#import "NetWork.h"
#import "MBCommunityModel.h"


//哔哔叨叨列表
#define LISTARTICLE_API @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/listArticle"
//热门动态列表
#define SEARCHHOTARTICLE_API @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/searchHotArticle"
//获取评论列表
#define GETREMARK_API @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/ArticleRemark/getremark"
//官方咨询列表
#define LISTNEWS_API @"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/Article/listNews"

@implementation MBCommunityNetWorking

+ (void)NetRequestPOSTwithDataType:(MBDataType)type WithParameter:(NSDictionary *)dic{
    //NetWork......
    
    //请求热门动态数据
    if (type == MBDataTypeCommunitySearchHot) {
        [NetWork NetRequestPOSTWithRequestURL:SEARCHHOTARTICLE_API WithParameter:dic WithReturnValeuBlock:^(id returnValue) {
            
        } WithFailureBlock:^{
            
        }];
    }
    
}

+ (void)NetUploadPOST {
    //upload.....
}

@end
