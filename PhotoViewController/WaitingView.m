//
//  WaitingView.m
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "WaitingView.h"
#define BG_WIDTH  100
#define BG_HEIGHT 100
//当前设备屏幕高度
#define UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define UIScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
//系统版本
#define CURRENT_VERSION [[UIDevice currentDevice].systemVersion floatValue]

@interface WaitingView()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation WaitingView

- (id)initWaitingView
{
    CGRect frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    return [self initWaitingView:frame];
}

- (id)initWaitingView:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        //背景框
        UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake((frame.size.width-BG_WIDTH)/2, (frame.size.height-BG_HEIGHT)/2 - 32, BG_WIDTH, BG_HEIGHT)];
        [bgview setBackgroundColor:[UIColor darkGrayColor]];
        bgview.layer.cornerRadius = 10;
        bgview.alpha=0.8;
        [self addSubview:bgview];
        [self loadImageWithFrame:frame];
    }
    return self;
}




/**
 *  覆盖区域不包含导航栏
 *
 *  @param frame 所覆盖的区域
 *
 *  @return
 */
- (id)initWatingViewWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        //背景框
        UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake((frame.size.width-BG_WIDTH)/2, (frame.size.height-BG_HEIGHT)/2+10, BG_WIDTH, BG_HEIGHT)];
        [bgview setBackgroundColor:[UIColor darkGrayColor]];
        bgview.center = CGPointMake(self.center.x,self.center.y - CGRectGetHeight(bgview.bounds)/ 2);
        bgview.layer.cornerRadius = 10;
        bgview.alpha=0.8;
        [self addSubview:bgview];
        [self loadImageWithFrame:frame];
        
    }
    return self;
    
    
}

- (void)loadImageWithFrame:(CGRect)frame
{
    UIImageView *loadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"load"]];
    if (frame.size.height == UIScreenHeight) {
        loadImageView.frame = CGRectMake((frame.size.width-48)/2, (frame.size.height-48)/2-32-16, 48, 48);
    }else{
        if (CURRENT_VERSION<7.0 && frame.size.height == UIScreenHeight-20) {
            loadImageView.frame = CGRectMake((frame.size.width-48)/2, (frame.size.height-48)/2-32-16, 48, 48);
        }else{
            loadImageView.frame = CGRectMake((frame.size.width-48)/2, (frame.size.height-48)/2-32, 48, 48);
        }
        
    }
    
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
    monkeyAnimation.duration = .5f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO; //No Remove
    
    monkeyAnimation.repeatCount = FLT_MAX;
    [loadImageView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"load_logo"]];
    
    if (frame.size.height == UIScreenHeight) {
        logoImageView.frame = CGRectMake((frame.size.width-24)/2, (frame.size.height-24)/2-32-16, 24, 24);
    }else{
        logoImageView.frame = CGRectMake((frame.size.width-24)/2, (frame.size.height-24)/2-32, 24, 24);
        
        if (CURRENT_VERSION<7.0 && frame.size.height == UIScreenHeight-20) {
            logoImageView.frame = CGRectMake((frame.size.width-24)/2, (frame.size.height-24)/2-32-16, 24, 24);
        }else{
            logoImageView.frame = CGRectMake((frame.size.width-24)/2, (frame.size.height-24)/2-32, 24, 24);
        }
    }
    [self addSubview:loadImageView];
    [self addSubview:logoImageView];
}

- (void)__show
{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    [mainWindow addSubview:self];
    self.alpha = 1.0f;
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.3;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.01],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    [self.contentView.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
    fadeInAnimation.duration = 0.3;
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.layer addAnimation:fadeInAnimation forKey:@"opacity"];
}

- (void)__hide
{
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)show:(UIView *)pView
{
    [pView addSubview:self];
    self.alpha = 1.0f;
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.3;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.01],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    [self.contentView.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
    fadeInAnimation.duration = 0.3;
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.layer addAnimation:fadeInAnimation forKey:@"opacity"];
}
- (void)show
{
    [self __show];
}

- (void)hide
{
    [self __hide];
}
@end
