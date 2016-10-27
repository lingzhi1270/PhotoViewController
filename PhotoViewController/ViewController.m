//
//  ViewController.m
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "ViewController.h"
#import "PhotoViewController.h"


@interface ViewController ()<UIScrollViewDelegate,photoViewDatasource,PhotoViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,assign)int page;

@end

@implementation ViewController

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.frame = CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 260);

//        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //防止上下动
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*4, 260);
        
        _scrollView.delegate = self;
        
       
        for (int i = 0; i < 4; i ++) {
            
            NSString *string = [NSString stringWithFormat:@"%d",i];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:string]];
            imageView.frame = CGRectMake(CGRectGetWidth(self.view.frame)*i, 0, CGRectGetWidth(self.view.frame), 260);
            imageView.userInteractionEnabled = YES;
            imageView.tag = i+1000;
            
            [_scrollView addSubview:imageView];
            
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleAction)];
            doubleTap.numberOfTapsRequired = 2;
            [imageView addGestureRecognizer:doubleTap];
            
            [self.dataArray addObject:imageView.image];
        }
        
    }
    return _scrollView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scrollView];
    
}

- (void)doubleAction
{
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    photoVC.title = @"图片控制器";
    
    //设置代理和数据源为self
    photoVC.delegate = self;
    photoVC.datasource = self;
    photoVC.currentPage = _page;
    [self.navigationController pushViewController:photoVC animated:YES];
    
    
}

#pragma mark- photoViewDatasource,PhotoViewDelegate

- (NSInteger)photosViewNumberOfCount
{
    return self.dataArray.count;
}

- (UIImage *)photosViewImageAtIndex:(NSInteger)index
{
    return self.dataArray[index];
}


- (void)photosViewBackAtIndex:(NSInteger)index
{
    
}


#pragma  mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
