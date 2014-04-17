//
//  FVImageSequence.h
//  Untitled
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    FVGestureDirectionHorizontal=0,  
    FVGestureDirectionVertical 
}FVGestureDirection;

typedef void (^CompletionBlock)(BOOL finished);
typedef void (^PicNameAtIndexBlock)(NSString *picName, NSUInteger index);

@interface FVImageSequence : UIImageView {
	NSString *prefix;
	NSString *extension;
	int increment;
    
    int previous;//触摸的前次位置
	int perDistance;//手势滑动的单位距离
    
    int firstIndex;
    int currentIndex;
    int lastIndex;
    
    BOOL animating;//自动播放中
}
@property (readwrite, copy) NSString *prefix;//图片名称前缀
@property (readwrite) int increment;//每次前进的帧数，默认为1(正常),2（两倍快进）
@property (readwrite, copy) NSString *extension;//图片类型后缀

@property (readwrite) BOOL cycle;//图片是否循环 alex
@property (nonatomic,retain) NSTimer *myAnimatedTimer;//计时器

@property (readwrite) int firstIndex;//第一帧图片编号
@property (readwrite) int currentIndex;//当前帧图片编号
@property (readwrite) int lastIndex;//最后帧图片编号

@property (readwrite) FVGestureDirection gestureDirection;//手势滑动方向(默认水平方向FVGestureDirectionHorizontal)alex


@property (nonatomic,copy) CompletionBlock completionBlock;


@property (nonatomic,copy) PicNameAtIndexBlock picNameAtIndexBlock;//图片切换回调


-(void)setPicNameAtIndexBlock:(PicNameAtIndexBlock)picNameAtIndexBlock;
-(void)setPrefix:(NSString*)pre firstIndex:(int )first lastIndex:(int)last extension:(NSString*)exten;


@property (readwrite) BOOL completedDelete;//动画结束后删除自己 alex
-(void)startAnimating:(CompletionBlock) completion;
-(void)startAnimating:(NSTimeInterval)time completion:(CompletionBlock) completion;
-(void)startAnimating:(NSTimeInterval)time completedDelete:(BOOL)delete completion:(CompletionBlock) completion;
-(void)pauseAnimating;//暂停播放
- (BOOL)animating;

@end
