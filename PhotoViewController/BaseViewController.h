//
//  BaseViewController.h
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaitingView;
/**
 * UIViewController基类
 */
@interface BaseViewController : UIViewController

@property(nonatomic,strong) WaitingView * waitingView;
@property(nonatomic,strong) UIScrollView * svNeedReset;
@property(assign,nonatomic) CGPoint scrollviewContentOffsetChange;

- (void)setCommonApperence;

- (void)createBackItem;


- (void)click_popViewController;
@end

/**
 * UIViewController基类,带导航栏返回按钮
 */
@interface BaseViewControllerWithBackButton :BaseViewController
- (void)click_popViewController;
@end

/**
 * UINavigationController基类,暂时继承此类，目前未实现任何代码
 */
@interface BaseUINavigationController : UINavigationController
@end
