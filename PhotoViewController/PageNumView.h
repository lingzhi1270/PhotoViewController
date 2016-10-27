//
//  PageNumView.h
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageNumView : UIView
@property (nonatomic,assign) BOOL   blackGroundFlag;            //是否是黑色背景，否则就是白色的


@property (nonatomic,assign) int countNum;                      //总个数




@property (nonatomic,assign) int currentPage;                   //当前个数

@end
