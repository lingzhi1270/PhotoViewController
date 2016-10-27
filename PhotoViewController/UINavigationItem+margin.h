//
//  UINavigationItem+margin.h
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (margin)
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
                                       customRect:(CGRect)rect;



@end
