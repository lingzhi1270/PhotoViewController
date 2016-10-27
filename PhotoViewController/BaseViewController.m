//
//  BaseViewController.m
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "BaseViewController.h"
#import "WaitingView.h"
#import "UIColor+Extend.h"
#import "UINavigationItem+margin.h"
//系统版本
#define CURRENT_VERSION [[UIDevice currentDevice].systemVersion floatValue]
@interface BaseViewController ()

@end

@implementation BaseViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor getColor:@"eeeeee"];
    
    
    self.waitingView = [[WaitingView alloc] initWaitingView];
    
    //设置导航栏字体颜色
    UILabel * myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 44)];
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    [myTitleLabel setBackgroundColor:[UIColor clearColor]];
    myTitleLabel.font = [UIFont systemFontOfSize:20];
    myTitleLabel.textColor = [UIColor blackColor];
    
    
    myTitleLabel.text = self.title;
    self.navigationItem.titleView = myTitleLabel;

    
}

// 用与解决IOS6 autolayout下 scrollview push后返回，如果push的时候contentOffset不为0，界面会上移的系统BUG -----begin
// 使用时，在viewDidLoad中将需要设置的scrollview指向  self.sv 即可
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.svNeedReset && CURRENT_VERSION < 7.0) {
        self.svNeedReset.contentOffset = CGPointZero;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.svNeedReset && CURRENT_VERSION < 7.0) {
        self.scrollviewContentOffsetChange = self.svNeedReset.contentOffset;
    }
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.svNeedReset && CURRENT_VERSION < 7.0) {
        self.svNeedReset.contentOffset = self.scrollviewContentOffsetChange;
    }
}
// 用与解决IOS6 autolayout下 scrollview push后返回，如果push的时候contentOffset不为0，界面会上移的系统BUG -----end

- (void)setCommonApperence
{
    
    //#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    //    if (CURRENT_VERSION>=7.0)
    //    {
    //        self.extendedLayoutIncludesOpaqueBars = NO;
    //        self.modalPresentationCapturesStatusBarAppearance = NO;
    //        self.navigationController.navigationBar.translucent = NO;
    //        self.automaticallyAdjustsScrollViewInsets = NO;
    //    }
    //#endif
    
}

/**
 *
 */
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

- (void)createBackItem
{
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    if (CURRENT_VERSION >= 7.0) {
        [backBtn setFrame:CGRectMake(0, 0, 12, 22)];
    } else {
        [backBtn setFrame:CGRectMake(0, 0, 12 + 22, 22)];
    }
    [backBtn setImage:[UIImage imageNamed:@"topnav_select_icon_arrow"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"topnav_select_icon_arrow_press"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(click_popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
}

- (void)click_popViewController
{
    if (self.waitingView) {
        [self.waitingView hide];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end


@implementation BaseViewControllerWithBackButton
- (void)click_popViewController
{
    if (self.waitingView) {
        [self.waitingView hide];
    }
    
   
        [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    if (CURRENT_VERSION >= 7.0)
    {
        [backBtn setFrame:CGRectMake(0, 0, 12, 22)];
    }
    else
    {
        [backBtn setFrame:CGRectMake(0, 0, 12 + 22, 22)];
    }
    [backBtn setImage:[UIImage imageNamed:@"topnav_select_icon_arrow"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"topnav_select_icon_arrow_press"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(click_popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

- (void)createBackItem
{
    
    UIImage *normalImage = [UIImage imageNamed:@"ios_btn_back_24x41_press"];
    UIImage *selectImage = [UIImage imageNamed:@"ios_btn_back_24x41"];
    
    [self.navigationItem createBarItemWithNormalImage:normalImage
                                          selectImage:selectImage
                                             selector:@selector(click_popViewController)
                                                owner:self
                                            direction:YES
                                           customRect:CGRectMake(0, 0, 20, 20.5)];
}
@end

@implementation BaseUINavigationController

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
@end
