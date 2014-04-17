//
//  FVImageSequence.m
//  Untitled
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FVImageSequence.h"


@implementation FVImageSequence
@synthesize prefix, firstIndex,currentIndex,lastIndex, extension, increment,cycle,myAnimatedTimer,completionBlock,gestureDirection,picNameAtIndexBlock,completedDelete;


- (id)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled=YES;//开启用户交互
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;//开启用户交互
        self.contentMode=UIViewContentModeScaleAspectFill;
        perDistance=5;//手势移动距离的单位长度
        increment = 1;//每次前进的帧数，默认为1(正常),2（两倍快进）
        
        gestureDirection=FVGestureDirectionHorizontal;//手势方向(0水平方向)
        
        completedDelete=YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
	
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (gestureDirection==FVGestureDirectionHorizontal) {
        previous = touchLocation.x;
    }else
        previous = touchLocation.y;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
	
    int location = touchLocation.x;
    if (gestureDirection==0) {
        location = touchLocation.x;
    }else
        location = touchLocation.y;
	
	if(location -previous<=-perDistance)
		currentIndex += increment;
	else if(location-previous>=perDistance)
		currentIndex -= increment;
    else {
        return;
    }
	
	previous = location;
	
    if(currentIndex > lastIndex){
        //alex start
        if (cycle) {
            currentIndex = firstIndex;
        }else {
            currentIndex = lastIndex;
        }
        //alex end
    }
    if(currentIndex < firstIndex){
        //alex start
        if (cycle) {
            currentIndex = lastIndex;
        }else {
            currentIndex=firstIndex;
        }
        //alex end
    }

    [self update_current_view];
}

-(void)dealloc{
	[extension release];
	[prefix release];
	[super dealloc];
}

#pragma mark custom
-(void)setPrefix:(NSString*)pre firstIndex:(int )first lastIndex:(int)last extension:(NSString*)exten{
    [self setPrefix:pre];
    [self setFirstIndex:first];
    [self setCurrentIndex:firstIndex];//current默认设置为first
    [self setLastIndex:last];
    [self setExtension:exten];
    //更新显示
    [self update_current_view];
}

#pragma mark animation
/*
-(void)setNextImage
{    
    currentIndex++;
    if(currentIndex <=lastIndex){
        [self update_current_view];
    }else {
        currentIndex=lastIndex;
        [myAnimatedTimer invalidate];
        myAnimatedTimer=nil;
        [UIView animateWithDuration:3 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}
 */

-(void)update_current_view{
    NSString *path = [NSString stringWithFormat:@"%@%05d", prefix, currentIndex];	
    path = [[NSBundle mainBundle] pathForResource:path ofType:extension];	
    UIImage *image =  [[UIImage alloc] initWithContentsOfFile:path];	
    self.image =image;
    [image release];
    NSLog(@"path:%@",path);
    NSLog(@"%d",currentIndex);
    
    if (picNameAtIndexBlock) {
        picNameAtIndexBlock(path,currentIndex);
    }
}

#pragma mark donghua
-(void)startAnimating{
    [self startAnimating:nil];
} 

-(void)startAnimating:(CompletionBlock) completion{
    [self startAnimating:0.05 completedDelete:YES completion:completion];
}

-(void)startAnimating:(NSTimeInterval)time completion:(CompletionBlock) completion{
    [self startAnimating:time completedDelete:YES completion:completion];
}


-(void)startAnimating:(NSTimeInterval)time completedDelete:(BOOL)delete completion:(CompletionBlock) completion{
    if (completion) {
        completionBlock=nil;
        self.completionBlock=completion;
    }
    
    completedDelete=delete;
    myAnimatedTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
    animating=YES;
}

-(void)pauseAnimating{
    [myAnimatedTimer invalidate];
    myAnimatedTimer=nil;
    
    animating=NO;
}


- (BOOL)animating{
    return animating;
}


-(void)onTimer:(NSTimer*)timer
{    
    currentIndex++;
    if(currentIndex <= lastIndex){
        [self update_current_view];
        //动画当前curent回调
    }else {
        currentIndex=lastIndex;
        [myAnimatedTimer invalidate];
        myAnimatedTimer=nil;
        animating=NO;
        
        if (completedDelete) {
            [UIView animateWithDuration:3 animations:^{
                self.alpha=0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];

                //动画结束回调
                if (completionBlock) {
                    completionBlock(YES);
                    completionBlock=nil;
                }
            }];        
        }else {
            //动画结束回调
            if (completionBlock) {
                completionBlock(YES);
                completionBlock=nil;
            }
        }
    }
}



@end
