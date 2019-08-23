//
//  SchoolPicScrollView.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/23.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SchoolPicScrollView.h"

@implementation SchoolPicScrollView

- (instancetype)initWithFrame:(CGRect)frame andPictures:(NSArray<NSURL *> *)imageURLArray {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        for (int i = 0; i < imageURLArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setImageWithURL:imageURLArray[i] placeholder:[UIImage imageNamed:@"SchoolPicNodataImg"]];
            imageView.frame = CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height);
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, (imageURLArray[i].size.height / imageURLArray[i].size.height) * frame.size.width)];
//            imageView.image = imageURLArray[i];
            [scrollView addSubview:imageView];
        }
        scrollView.contentSize = CGSizeMake(frame.size.width * imageURLArray.count, frame.size.height);
        scrollView.pagingEnabled = YES;
    }
    return self;
}

@end
