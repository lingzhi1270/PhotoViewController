//
//  PageNumView.m
//  PhotoViewController
//
//  Created by lingzhi on 2016/10/26.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "PageNumView.h"
#import "Masonry.h"
//#import "MASUtilities.h"
//#define equalTo(...)                     mas_equalTo(__VA_ARGS__)

@interface PageNumView()
{
    UILabel *_numLabel;
    UIImageView *_backGroundView;
    
}

@end

@implementation PageNumView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor clearColor];
        [self setup];
        
    }
    
    return self;
}


- (id)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    
    _backGroundView = [[UIImageView alloc] init];
    _backGroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backGroundView];
    
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = [UIFont systemFontOfSize:14.0f];
    _numLabel.backgroundColor = [UIColor clearColor];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.adjustsFontSizeToFitWidth = YES;
    
    [_backGroundView addSubview:_numLabel];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(25, 20));
        
        
        make.center.mas_equalTo((_backGroundView.center));
    }];
    
}

- (void)setCountNum:(int)countNum
{
    _countNum = countNum;
    
}

- (void)setBlackGroundFlag:(BOOL)blackGroundFlag
{
    if (blackGroundFlag)
    {
        [_backGroundView setImage:[UIImage imageNamed:@"ios-picture_number_blackbg_56x56"]];
        _numLabel.textColor = [UIColor whiteColor];

    }
    else
    {
        [_backGroundView setImage:[UIImage imageNamed:@"ios-picture_number_blackbg_56x56"]];
        _numLabel.textColor = [UIColor whiteColor];

    }
}


- (void)setCurrentPage:(int)currentPage
{
    _currentPage = currentPage;
    
    _numLabel.text = [NSString stringWithFormat:@"%d/%d",_currentPage+1,_countNum];;
    
}
@end
