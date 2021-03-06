//
//  PhotoView.m
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"
//当前设备屏幕高度
#define UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define UIScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
//颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface PhotoView()<UIScrollViewDelegate>
{
    UIImageView  *_imageView;
    UIScrollView *_scrollView;
    CGFloat currentScale;//当前倍率
    
    CGFloat minScale;//最小倍率
}

@end

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    //最大放大倍数(默认值)
    _maxScale = 2.0;
    //设置最小倍率为1.0
    minScale = 1.0;
    //设置当前的放大倍数
    currentScale = 1.0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.center = self.center;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.maximumZoomScale=2.0;//最大倍率（默认倍率）
    _scrollView.minimumZoomScale=1.0;//最小倍率（默认倍率）
    _scrollView.decelerationRate=1.0;//减速倍率（默认倍率）
    _scrollView.delegate=self;
    [self addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenWidth)];
    _imageView.center = self.center;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [_scrollView addSubview:_imageView];
    
    UITapGestureRecognizer *doubelGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleGesture:)];
    doubelGesture.numberOfTapsRequired=2;
    [_scrollView addGestureRecognizer:doubelGesture];
    
    
    UITapGestureRecognizer *singlelGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleGesture:)];
    singlelGesture.numberOfTapsRequired=1;
    [_scrollView addGestureRecognizer:singlelGesture];
    
    [singlelGesture requireGestureRecognizerToFail:doubelGesture];

    
}

/**
 *网络图片
 */
- (void)initWithUrl:(NSString *)url  placeholderImage:(UIImage *)image
{
    __weak typeof(PhotoView *)bself = self;
    [_imageView  setImageWithURL:[NSURL URLWithString:url] placeholderImage:image options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [bself adjustFrame];
    }];
    
}

/**
 *本地图片
 */
- (void)initWithImage:(UIImage *)image
{
    
    if (image)
    {
        [_imageView setImage:image];
        
        [self adjustFrame];
    }
}

- (void)adjustFrame
{
    
    if (_imageView.image)
    {
        // 基本尺寸参数
        CGSize boundsSize = self.bounds.size;
        CGFloat boundsWidth = boundsSize.width;
        
        
        CGSize imageSize = _imageView.image.size;
        CGFloat imageWidth = imageSize.width;
        CGFloat imageHeight = imageSize.height;
        
        
        CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
        // 内容尺寸
        _scrollView.contentSize = CGSizeMake(0, imageFrame.size.height);
        
        _imageView.frame = imageFrame;
        _imageView.center = _scrollView.center;
        
    }
}

- (void)resetScale
{
    
    [_scrollView setZoomScale:_scrollView.minimumZoomScale    animated:YES];
    
}

#pragma mark -DoubleGesture Action
-(void)doubleGesture:(UIGestureRecognizer *)sender
{
    
    //当前倍数等于最大放大倍数
    //双击默认为缩小到原图
    if (currentScale==_maxScale)
    {
        currentScale=minScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }
    //当前等于最小放大倍数
    //双击默认为放大到最大倍数
    if (currentScale==minScale)
    {
        currentScale=_maxScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }
    
    CGFloat aveScale =minScale+(_maxScale-minScale)/2.0;//中间倍数
    
    //当前倍数大于平均倍数
    //双击默认为放大最大倍数
    if (currentScale>=aveScale)
    {
        currentScale=_maxScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }
    
    //当前倍数小于平均倍数
    //双击默认为放大到最小倍数
    if (currentScale<aveScale)
    {
        currentScale=minScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }
}


- (void)singleGesture:(UIGestureRecognizer *)sender
{
    if (self.singleRecognizerTapBlock)
    {
        self.singleRecognizerTapBlock();
    }
    
}

#pragma mark- UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //重新定位中心点
    
    CGFloat offsetX = (_scrollView.bounds.size.width > _scrollView.contentSize.width)?
    (_scrollView.bounds.size.width - _scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (_scrollView.bounds.size.height > _scrollView.contentSize.height)?
    (_scrollView.bounds.size.height - _scrollView.contentSize.height) * 0.5 : 0.0;
    
    _imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX,
                                    _scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)dealloc
{
    _imageView = nil;
    _scrollView = nil;
}
@end
