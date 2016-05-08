//
//  MBBrowserItem.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/19.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBBrowserItem.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "UIShortTapGestureRecognizer.h"
#import "UIImage+Helper.h"

const CGFloat kMaximumZoomScale = 3.0f;
const CGFloat kMinimumZoomScale = 1.0f;
const CGFloat kDuration = 0.18f;

@interface MBBrowserItem ()<UIScrollViewDelegate,UIActionSheetDelegate>

@property (nonatomic,assign) CGPoint originalPoint;

@end

@implementation MBBrowserItem


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.maximumZoomScale = kMaximumZoomScale;
        self.minimumZoomScale = kMinimumZoomScale;
        self.zoomScale = 1.0f;
        [self addSubview:self.imageView];
        [self setupGestures];

    }
    return self;
}

- (void)setPic:(NSString *)pic {
    _pic = pic;
    [self.imageView setShowActivityIndicatorView:YES];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.pic] placeholderImage:[UIImage imageWithBgColor:BACK_GRAY_COLOR] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.frame = [self calculateDestinationFrameWithSize:self.imageView.image.size];
    }];
}

- (void)setThumbnailPic:(UIImage *)thumbnailPic {
    
}

- (void)setupGestures {
    UIShortTapGestureRecognizer *singleTap = [[UIShortTapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleSingleTap:)];
    UIShortTapGestureRecognizer *doubleTap = [[UIShortTapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleDoubleTap:)];
    UIShortTapGestureRecognizer *twoFingerTap = [[UIShortTapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(handleTwoFingerTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    twoFingerTap.numberOfTouchesRequired = 2;
    [self addGestureRecognizer:singleTap];
    [self.imageView addGestureRecognizer:doubleTap];
    [self.imageView addGestureRecognizer:twoFingerTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (CGRect)calculateDestinationFrameWithSize:(CGSize)size{
    CGRect rect = CGRectMake(0.0f,
                             (ScreenHeight - size.height * ScreenWidth/size.width)/2,
                             ScreenWidth,
                             size.height * ScreenWidth/size.width);
    return rect;
}

#pragma mark - UIScrollViewDelegate
/**
 *  缩放对象
 *
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

/**
 *  缩放结束
 *
 */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale + 0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

/**
 *  让UIImageView在UIScrollView缩放后居中显示
 *
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - UIGestureRecognizerHandler
/**
 *  单击
 *
 */
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"单机");
    if (gestureRecognizer.numberOfTapsRequired == 1) {
        if ([self.eventDelegate respondsToSelector:@selector(didClickedItemToHide)]) {
            [self.eventDelegate didClickedItemToHide];
        }
    }
}

/**
 *  双击
 *
 */
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"双击");
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        if(self.zoomScale == 1){
            float newScale = [self zoomScale] * 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        } else {
            float newScale = [self zoomScale] / 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        }
    }
}

- (void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecongnizer{
    float newScale = [self zoomScale]/2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecongnizer locationInView:self]];
    [self zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width = [self frame].size.width / scale;
    zoomRect.origin.x = center.x - zoomRect.size.width / 2;
    zoomRect.origin.y = center.y - zoomRect.size.height / 2;
    return zoomRect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
