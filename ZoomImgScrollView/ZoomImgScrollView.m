//
//  ZoomImgScrollView.m
//  BRSD
//
//  Created by mac on 12-10-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZoomImgScrollView.h"

@interface ZoomImgScrollView ()
@property(nonatomic,strong)UIImageView *imgView;//内容视图:UIView机器子视图均可
@end


@implementation ZoomImgScrollView
@synthesize imgView=_imgView;
@synthesize scrollViewContentMode=_scrollViewContentMode;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = YES;
        self.delegate=self;
        self.backgroundColor=[UIColor clearColor];
        
        self.bounces=YES;
        self.bouncesZoom=YES;
        self.minimumZoomScale=1;
        self.maximumZoomScale=3;
        
        _imgView=[[UIImageView alloc] initWithFrame:frame];
        _imgView.backgroundColor=[UIColor clearColor];
        //_imgView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];
        
//        [_imgView.layer setBorderWidth:2.0];
//        [_imgView.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
//        [self.layer setBorderWidth:2.0];
//        [self.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setScrollViewContentMode:(UIScrollViewContentMode)scrollViewContentMode{
    _scrollViewContentMode=scrollViewContentMode;
    [self setContentImage:_imgView.image];
}

-(void)setContentImage:(UIImage *)image{
    if (image) {
        NSLog(@"zoomScale:%f",self.zoomScale);
        self.zoomScale=1;//重置zoomScale
        
        //图片在scrollView中的显示模: UIViewContentModeScaleAspectFit,UIViewContentModeScaleAspectFit按比例缩放imageView，保证imgeView全部显示
        float x_scale = self.frame.size.width/image.size.width;
        float y_scale = self.frame.size.height/image.size.height;
        CGFloat scale=1;
        if (_scrollViewContentMode==UIScrollViewContentModeLonger) {
            scale = x_scale <y_scale ? x_scale : y_scale;
        }else if(_scrollViewContentMode==UIScrollViewContentModeShorter){
            scale = x_scale >y_scale ? x_scale : y_scale;
        }
        CGRect frame=self.frame;
        frame.size.width=image.size.width*scale;
        frame.size.height=image.size.height*scale;
        _imgView.frame=frame;//重置frame
        _imgView.image=image;
        _imgView.backgroundColor=[UIColor whiteColor];
        //NSLog(@"widht1:%f,height1:%f",frame.size.width ,frame.size.height);
        [self setContentSize:CGSizeMake(_imgView.frame.size.width,_imgView.frame.size.height)];
        //_imgView.center=CGPointMake(self.contentSize.width/2, self.contentSize.height/2);
        
        //内容对齐方式更新显示
        [self update_contentAlignType_view];
    }
}

//内容对齐方式更新显示
-(void)update_contentAlignType_view{
    //UIScrollView上的子视图始终保持居中显示
    CGFloat xcenter = self.center.x , ycenter = self.center.y;
    xcenter = self.contentSize.width > self.frame.size.width ? self.contentSize.width/2 : xcenter;
    //同上，此处修改y值
    ycenter = self.contentSize.height > self.frame.size.height ? self.contentSize.height/2 : ycenter;
    [_imgView setCenter:CGPointMake(xcenter, ycenter)];
}

#pragma mark touches
/*双击放大/缩小内容功能*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([[touches anyObject] tapCount] == 2){
        CGPoint point = [[touches anyObject] locationInView:self];
        CGFloat zs = self.zoomScale;
        zs = (zs == 1.0) ? 2.0 : 1.0;

        CGRect zoomRect;
        zoomRect.size.height = self.frame.size.height/zs;
        zoomRect.size.width  = self.frame.size.width/zs;
        zoomRect.origin.x    = point.x - (zoomRect.size.width  / 2.0);
        zoomRect.origin.y    = point.y - (zoomRect.size.height / 2.0);
        [self zoomToRect:zoomRect animated:YES];
    }
}



#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{


}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
    return _imgView; //返回ScrollView上添加的需要缩放的视图
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{


}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //内容对齐方式更新显示
    [self update_contentAlignType_view];
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{

}




@end
