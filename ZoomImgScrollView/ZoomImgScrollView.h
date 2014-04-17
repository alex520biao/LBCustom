//
//  ZoomImgScrollView.h
//  BRSD
//
//  Created by mac on 12-10-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    UIScrollViewContentModeLonger,  //以UIImageView较长的一边为基准(完整显示UIImage的内容)
    UIScrollViewContentModeShorter ////以UIImageView较长的一边为基准(只显示一部分，其余部分需要拖动查看)     
} UIScrollViewContentMode;//UIScrollView上的UIImageView显示方式

@interface ZoomImgScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, assign) UIScrollViewContentMode scrollViewContentMode;//default,UIScrollViewContentModeLonger
-(void)setContentImage:(UIImage *)image;//设置image必须通过setImage方法,imgView为私有属性
@end
