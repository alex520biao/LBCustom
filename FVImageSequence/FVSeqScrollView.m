//
//  FVSeqZoomView.m
//  PURE HILL
//
//  Created by Alex on 13-1-28.
//
//

#import "FVSeqScrollView.h"

@implementation FVSeqScrollView
@synthesize imageSequence=_imageSequence;

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
        
        FVImageSequence *imageSquence=[[FVImageSequence alloc] initWithFrame:self.bounds];
        imageSquence.tag=10086;//表示将会获取事件
        //[imageSquence setPrefix:itemObj.imgSeq.prefix firstIndex:itemObj.imgSeq.firstIndex lastIndex:itemObj.imgSeq.lastIndex extension:itemObj.imgSeq.extension];
        //imageSquence.cycle=itemObj.imgSeq.cycle;//图片是否循环
        imageSquence.backgroundColor=[UIColor clearColor];
        //imageSquence.center=CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2);
        imageSquence.clipsToBounds=YES;
        [self addSubview:imageSquence];
        self.imageSequence=imageSquence;
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

-(void)setItemObj:(ItemObj*)itemObj{
    if (itemObj) {
        NSLog(@"zoomScale:%f",self.zoomScale);
        self.zoomScale=1;//重置zoomScale
        self.imageSequence.frame=self.frame;//重置frame
        
        [_imageSequence setPrefix:itemObj.imgSeq.prefix firstIndex:itemObj.imgSeq.firstIndex lastIndex:itemObj.imgSeq.lastIndex extension:itemObj.imgSeq.extension];
        _imageSequence.cycle=itemObj.imgSeq.cycle;//图片是否循环
        UIImage *image=_imageSequence.image;

        //图片在scrollView中的显示模: UIViewContentModeScaleAspectFit,UIViewContentModeScaleAspectFit按比例缩放imageView，保证imgeView全部显示
        float x_scale = self.frame.size.width/image.size.width;
        float y_scale = self.frame.size.height/image.size.height;
        CGFloat scale = x_scale < y_scale ? x_scale : y_scale;
        CGRect frame=self.frame;
        frame.size.width=image.size.width*scale;
        frame.size.height=image.size.height*scale;
        self.imageSequence.frame=frame;        
        self.imageSequence.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.imageSequence.backgroundColor=[UIColor whiteColor];
    }
}

#pragma mark touches
/*双击放大/缩小内容功能*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //imageSequence自动播放时禁止缩放
    if (_imageSequence.animating) {
        return;
    }
    
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
    return _imageSequence; //返回ScrollView上添加的需要缩放的视图
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
    
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? \
    scrollView.contentSize.width/2 : xcenter;
    //同上，此处修改y值
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? \
    scrollView.contentSize.height/2 : ycenter;
    [_imageSequence setCenter:CGPointMake(xcenter, ycenter)];
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
}



@end
