//
//  UINavigationItem+margin.m
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "UINavigationItem+margin.h"
#import "UIButton+Addtions.h"
@implementation UINavigationItem (margin)
/**
 *  创建导航栏上的item
 *
 *  @param image1      未选中图片
 *  @param image2      选中图片
 *  @param aSelector   选中时触发的方法
 *  @param aOwner      拥有者
 *  @param leftOrRight 左侧还是右侧  （YES:左   NO:右）
 *  @param rect        视图大小
 *
 *  @return item
 */
- (UIBarButtonItem *)createBarItemWithNormalImage:(UIImage *)image1
                                      selectImage:(UIImage *)image2
                                         selector:(SEL)aSelector
                                            owner:(id)aOwner
                                        direction:(BOOL)leftOrRight
                                       customRect:(CGRect)rect
{
    
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x , rect.origin.y, rect.size.width+ 10 , rect.size.height)];
    backGroundView.backgroundColor = [UIColor clearColor];
    
    UIButton  *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonItem setImage:image1 forState:UIControlStateNormal];
    [buttonItem setImage:image2 forState:UIControlStateHighlighted];
    
    float x = leftOrRight ? 0 : 10;
    buttonItem.frame = CGRectMake(x, 0, rect.size.width, rect.size.height);
    [buttonItem addTarget:aOwner action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
    float left = leftOrRight ? 0: 10;
    
    float right = leftOrRight ? 10: 0;
    [buttonItem setEnlargeEdgeWithTop:0 right:right bottom:0 left:left];
    [backGroundView addSubview:buttonItem];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backGroundView];
    
    if (leftOrRight)
    {
        self.leftBarButtonItem = barItem;
    }else
    {
        self.rightBarButtonItem = barItem;
    }
    
    return barItem;
    
    
    
}

@end
