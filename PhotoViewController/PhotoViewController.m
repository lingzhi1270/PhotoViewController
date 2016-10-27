//
//  PhotoViewController.m
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "PhotoViewController.h"
#import "PageNumView.h"
#import "PhotoView.h"
#import "UIView+Additions.h"

//当前设备屏幕高度
#define UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define UIScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
//系统版本
#define CURRENT_VERSION [[UIDevice currentDevice].systemVersion floatValue]
@interface PhotoViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_photoArray;
    PageNumView *_pageNumView;
    
}
@end

@implementation PhotoViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (CURRENT_VERSION > 7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self setup];
    [self initWithDataSource];
    
}


/**
 *  返回上级菜单
 */
- (void)popView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(photosViewBackAtIndex:)]) {
        [self.delegate photosViewBackAtIndex:self.currentPage];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setup
{
    
    self.view.backgroundColor = [UIColor blackColor];
    _photoArray = [[NSMutableArray alloc] init];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.center = self.view.center;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    
    
    
    _pageNumView = [[PageNumView alloc] initWithFrame:CGRectMake(UIScreenWidth-50, 45, 28, 28)];
    _pageNumView.blackGroundFlag = YES;
    [self.view addSubview:_pageNumView];
}


/**
 *  初始化数据
 */
- (void)initWithDataSource
{
    
    if (!self.datasource) return;
    
    int count = [self.datasource photosViewNumberOfCount];
    for (int i = 0; i<count; i ++)
    {
        PhotoView     *picView = [[PhotoView alloc] initWithFrame:_scrollView.bounds];
        picView.frameX = i *UIScreenWidth;
        
        if ([self.datasource respondsToSelector:@selector(photosViewUrlAtIndex:)])
        {
            NSString *url = [self.datasource photosViewUrlAtIndex:i];
            
            NSString *temp = @"local";
            if ([url rangeOfString:temp].location != NSNotFound)
            {
                url = [url substringFromIndex:temp.length];
                UIImage *tempImage = [[UIImage   alloc] initWithContentsOfFile:url];
                [picView initWithImage:tempImage];
            }else
            {
                
                [picView initWithUrl:url placeholderImage:[UIImage imageNamed:@"load_logo"]];
            }
        }
        
        if ([self.datasource respondsToSelector:@selector(photosViewImageAtIndex:)])
        {
            UIImage *image = [self.datasource photosViewImageAtIndex:i];
            [picView initWithImage:image];
        }
        
        __weak  typeof(self)bself = self;
        picView.singleRecognizerTapBlock = ^{
            [bself popView];
        };
        [_scrollView addSubview:picView];
        
        [_photoArray addObject:picView];
    }
    [_scrollView setContentSize:CGSizeMake(UIScreenWidth*count, _scrollView.frameHeight)];
    [_scrollView scrollRectToVisible:CGRectMake(UIScreenWidth * self.currentPage, 0, UIScreenWidth, _scrollView.frameHeight) animated:YES];
    
    _pageNumView.countNum = count;
    
    _pageNumView.currentPage = self.currentPage;
    
}

#pragma mark -
#pragma mark - 滚动视图代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.currentPage = floorf(scrollView.contentOffset.x/scrollView.bounds.size.width);
    
    _pageNumView.currentPage = self.currentPage ;
    for (PhotoView *view in _photoArray)
    {
        [view resetScale];
    }
}




- (void)dealloc
{
    
    _scrollView = nil;
    
    _photoArray = nil;
    
    _pageNumView = nil;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
