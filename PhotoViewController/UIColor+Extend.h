//
//  UIColor+Extend.h
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)
/*
 将十六进制的颜色值转为objective-c的颜色
 */
+ (id)getColor:(NSString *) hexColor;



+ (UIColor *)randomColor;

@end
