//
//  MBPhotoBrowser.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBPhotoBrowser.h"
#import "MBBrowserItem.h"
#import "UIImage+ImageEffects.h"
#import "UIImage+Helper.h"

#define PhotoBrowserImageViewMargin 10

#define kImageBrowserWidth ([UIScreen mainScreen].bounds.size.width + 10.0f)
#define kImageBrowserHeight [UIScreen mainScreen].bounds.size.height

@interface MBPhotoBrowser ()<UIScrollViewDelegate,MBBrowserItemEventDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *blurImageView;
@property (strong, nonatomic) UIImage* screenshot;
@property (strong, nonatomic) UILabel *indexLabel;
@property (strong, nonatomic) NSMutableArray *imageViewArray;
@property (assign, nonatomic) BOOL hasShowedFistView;


@end

@implementation MBPhotoBrowser

- (instancetype)initWithSourceContainerView:(UIView *)sourceContainerView
                           currentImageItem:(NSInteger)currentImageItem
                           sourceImageArray:(NSArray *)sourceImageArray
                sourceThumbnailPictureArray:(NSArray *)sourceThumbnailPictureArray
                       imageViewOriginArray:(NSArray *)imageViewOriginArray {
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _sourceContainerView = sourceContainerView;
        _currentImageItem = currentImageItem;
        _sourceImageArray = sourceImageArray;
        _sourceThumbnailPictureArray = sourceThumbnailPictureArray;
        _imageViewOriginArray = imageViewOriginArray;
        self.screenshot = [self _screenshotFromView:[UIApplication sharedApplication].keyWindow];
        [self addSubview:self.blurImageView];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage* blurImage = [weakSelf.screenshot applyBlurWithRadius:20
                                                            tintColor:RGBColor(0, 0, 0, 0.85)
                                                saturationDeltaFactor:1.4
                                                            maskImage:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                _blurImageView.image = blurImage;
                [UIView animateWithDuration:0.1f animations:^{
                    _blurImageView.alpha = 1.0f;
                }];
            });
        });
        [self setupScrollView];
        [self setupToolBar];
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    
    return self;
}
//获取屏幕截图
- (UIImage *)_screenshotFromView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size,NO,[UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

- (UIImageView *)blurImageView {
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _blurImageView.alpha = 0.0f;
    }
    return _blurImageView;
}

- (void)setupToolBar {
    _indexLabel= [[UILabel alloc]init];
    _indexLabel.textColor = [UIColor whiteColor];
    _indexLabel.textAlignment = NSTextAlignmentCenter;
    _indexLabel.bounds = CGRectMake(0, 0, 80, 30);
    _indexLabel.font = [UIFont systemFontOfSize:16];
    _indexLabel.clipsToBounds = YES;
    if (self.sourceImageArray.count > 0) {
        _indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentImageItem+1,self.sourceImageArray.count];
    }
    _indexLabel.center = CGPointMake(ScreenWidth * 0.5, 35);
}

- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kImageBrowserWidth, ScreenHeight)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(kImageBrowserWidth * self.sourceImageArray.count, 0);
    _scrollView.contentOffset = CGPointMake(self.currentImageItem * kImageBrowserWidth, 0);
    _scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollView];
    
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    _scrollView.hidden = YES;
    
    
    MBBrowserItem *browserItem = [[MBBrowserItem alloc]initWithFrame:self.bounds];
    
    browserItem.eventDelegate = self;
    
    browserItem.imageView.frame = CGRectFromString(self.imageViewOriginArray[self.currentImageItem]);
    
    browserItem.tag = self.currentImageItem;
    
    [_imageViewArray addObject:browserItem];
    
    [browserItem.imageView sd_setImageWithURL:[NSURL URLWithString:self.sourceThumbnailPictureArray[self.currentImageItem]] placeholderImage:[UIImage imageWithBgColor:BACK_GRAY_COLOR]];
    CGRect rect = [self calculateDestinationFrameWithSize:browserItem.imageView.image.size index:0];
    
    [self addSubview:browserItem];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        browserItem.imageView.frame = rect;
    } completion:^(BOOL finished) {
        [weakSelf loadPreAndNextItem];
        [browserItem removeFromSuperview];
        _scrollView.hidden = NO;
        [weakSelf addSubview:_indexLabel];
        browserItem.frame = CGRectMake(kImageBrowserWidth * self.currentImageItem, 0, ScreenWidth, kImageBrowserHeight);
        browserItem.pic = weakSelf.sourceImageArray[weakSelf.currentImageItem];
        browserItem.thumbnailPic = weakSelf.sourceThumbnailPictureArray[weakSelf.currentImageItem];
//        browserItem.thumbnailPic = browserItem.imageView.image;
        [_scrollView addSubview:browserItem];
        
        
    }];
}

- (NSMutableArray *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.currentImageItem = (NSInteger)(self.scrollView.contentOffset.x / ScreenWidth + 0.5);
     _indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentImageItem+1,self.sourceImageArray.count];
}

- (void)loadPreAndNextItem {
    for (NSInteger i = 0; i < self.sourceImageArray.count; i ++) {
        if (i != self.currentImageItem) {
            MBBrowserItem *browserItem = [[MBBrowserItem alloc]initWithFrame:CGRectMake(kImageBrowserWidth * i, 0, ScreenWidth, kImageBrowserHeight)];
            browserItem.pic = self.sourceImageArray[i];
            browserItem.thumbnailPic = self.sourceThumbnailPictureArray[i];
            browserItem.eventDelegate = self;
            [_scrollView addSubview:browserItem];
            browserItem.tag = i;
            [_imageViewArray addObject:browserItem];
        }
    }
}
#pragma mark MBBroswerItem Delegate
- (void)didClickedItemToHide {
    UIImageView *tem = [[UIImageView alloc]init];
    [tem sd_setImageWithURL:[NSURL URLWithString:self.sourceThumbnailPictureArray[self.currentImageItem]] placeholderImage:nil];
    CGRect rect = [self calculateDestinationFrameWithSize:tem.image.size index:0];
    tem.frame = rect;

    tem.contentMode = UIViewContentModeScaleAspectFill;
    tem.clipsToBounds = YES;
    
    _scrollView.hidden = YES;
    [_indexLabel removeFromSuperview];
    [self addSubview:tem];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        tem.frame = CGRectFromString(weakSelf.imageViewOriginArray[weakSelf.currentImageItem]);
        weakSelf.blurImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


- (CGRect)calculateDestinationFrameWithSize:(CGSize)size
                                      index:(NSInteger)index {
    CGRect rect = CGRectMake(kImageBrowserWidth * index,
                             (ScreenHeight - size.height * ScreenWidth / size.width)/2,
                             ScreenWidth,
                             size.height * ScreenWidth / size.width);
    return rect;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
