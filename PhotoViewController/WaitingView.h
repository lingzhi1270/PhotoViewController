//
//  WaitingView.h
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitingView : UIControl

@property(nonatomic,strong)UILabel *showTitle;

- (id)initWaitingView;
- (id)initWaitingView:(CGRect)frame;


- (void)show:(UIView *)pView;
- (void)show;
- (void)hide;


/**
 *  覆盖区域不包含导航栏
 *
 *  @param frame 所覆盖的区域
 *
 *  @return
 */
- (id)initWatingViewWithFrame:(CGRect)frame;

@end

