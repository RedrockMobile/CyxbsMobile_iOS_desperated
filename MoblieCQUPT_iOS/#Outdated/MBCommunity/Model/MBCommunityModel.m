//
//  MBCommunityModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityModel.h"
#define PHOTOURL @"https://wx.idsbllp.cn/cyxbsMobile/Public/photo/"
#define PHOTOURL2 @"http://wx.idsbllp.cn/cyxbsMobile/Public/photo/"
@implementation MBCommunityModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.cellIsOpen = NO;
        //type_id
        self.type_id = dic[@"type_id"];
        self.user_id = dic[@"user_id"]?:dic[@"stunum"];

        self.article_id = dic[@"article_id"]?:dic[@"id"];
        switch (self.type_id.integerValue) {
            case 1:
                self.nickname = @"重邮新闻";
                break;
            case 2:
                self.nickname = @"教务在线";
                break;
            case 3:
                self.nickname = @"学生咨询";
                break;
            case 4:
                self.nickname = @"校务公告";
                break;
            default:
                self.nickname = dic[@"nickname"];
                if ([self.nickname isEqualToString:@""]) {
                    self.nickname = @"这个人懒到没有填名字";
                }
                break;
        }
        self.content = dic[@"content"];
        self.detailContent = dic[@"content"];
        if(![self.type_id isEqualToNumber:@5]){
            if (![self.type_id isEqualToNumber:@7]) {
                self.content = dic[@"title"];
            }
            self.detailContent = [self removeHTML:self.detailContent];
            
        }
        NSString *time = dic[@"time"]?:dic[@"created_time"];
        self.time = [time substringToIndex:10];
        self.like_num = dic[@"like_num"];
        self.remark_num = dic[@"remark_num"];
        self.is_my_like = [dic[@"is_my_like"] boolValue];
        self.user_photo_src = dic[@"user_photo_src"];
        self.article_photo_src = dic[@"article_photo_src"];
        self.article_thumbnail_src = dic[@"article_photo_src"];
        if (![self.article_photo_src isEqualToString:@""]) {
            self.articlePictureArray = [self.article_photo_src componentsSeparatedByString:@","].mutableCopy;
        }
        if (![self.article_thumbnail_src isEqualToString:@""]) {
            self.articleThumbnailPictureArray = [self.article_thumbnail_src componentsSeparatedByString:@","].mutableCopy;
        }
        
        //通过用户头像URL判断http／https
        NSString *preStr = [[NSString alloc] init];
        if ([self.user_photo_src hasPrefix:@"https"]) {
            preStr = PHOTOURL;
        } else {
            preStr = PHOTOURL2;
        }

        for(int i = 0;i<self.articlePictureArray.count;i++){
            if (![self.articlePictureArray[i] hasPrefix:PHOTOURL] && ![self.articlePictureArray[i] hasPrefix:PHOTOURL2]) {
                self.articlePictureArray[i] = [preStr stringByAppendingString:self.articlePictureArray[i]];
            }
        }
        for (int i=0; i<self.articleThumbnailPictureArray.count; i++) {
            if (![self.articleThumbnailPictureArray[i] hasPrefix:PHOTOURL] && ![self.articleThumbnailPictureArray[i] hasPrefix:PHOTOURL2]) {
                [preStr stringByAppendingString:@"thumbnail/"];
                self.articleThumbnailPictureArray[i] =  [preStr stringByAppendingString:self.articleThumbnailPictureArray[i]];
            }
        }
    }
    return self;
}
- (NSString *)removeHTML:(NSString *)html {
    NSScanner *theScanner;
    NSString *text = nil;
    html = [html stringByReplacingOccurrencesOfString: @"\r" withString:@""];
    html = [html stringByReplacingOccurrencesOfString: @"&nbsp" withString:@""];
    html = [html stringByReplacingOccurrencesOfString: @"\t" withString:@"  "];
    
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return html;
}


@end
