//
//  UIColumnView.m
//  iProduct
//
//  Created by Hager Hu on 5/23/11.
//  Copyright 2011 dreamblock.net. All rights reserved.
//

#import "UIColumnView.h"


@implementation UIColumnView


@synthesize itemDataList;

@synthesize viewDelegate;
@synthesize viewDataSource;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate=self;//alex
        onScreenViewDic = [[NSMutableDictionary alloc] init];
        offScreenViewDic = [[NSMutableDictionary alloc] init];
        
        originPointList = [[NSMutableArray alloc] init];
        
        numberOfColumns = 0;
        
        startIndex = 0;
        endIndex = 0;
        //S alex UIScrollView上的子视图的单击及多动事件处理
        [self setDelaysContentTouches:YES];//立即调用touchesShouldBegin:withEvent:inContentView检查是否滚动,default YES
        [self setCanCancelContentTouches:YES];//发送滚动的通知,default YES
        //E alex
    }
    
    return self;
}

#pragma mark -
#pragma mark Public method implementation

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    if ([[offScreenViewDic allKeys] containsObject:identifier]) {
    	NSMutableSet *cacheSet = (NSMutableSet *)[offScreenViewDic objectForKey:identifier];
        id reused = [cacheSet anyObject];
        if (reused != nil) {
            [[reused retain] autorelease];
            [cacheSet removeObject:reused];
            
            return (UITableViewCell *)reused;
        }
    }
    
    return nil;
}


#pragma mark -

- (float)contentSizeWidth {
    float width = 0.0;
    numberOfColumns = viewDataSource == nil ? 0 : [viewDataSource numberOfColumnsInColumnView:self];
    for (int i = 0; i < numberOfColumns; i++) {
        float itemWidth = [viewDelegate columnView:self widthForColumnAtIndex:i];
        width += itemWidth;
    }
    //NSLog(@"content size: %f", width);
    
    return width;
}


- (void)calculateAllItemsOrigin {
    float viewOrigin = 0;
    for (int i = 0; i < numberOfColumns; i++) {
        [originPointList addObject:[NSNumber numberWithFloat:viewOrigin]];
        viewOrigin += [viewDelegate columnView:self widthForColumnAtIndex:i];
    }
}


- (void)reloadData {
    numberOfColumns = viewDataSource == nil ? 0: [viewDataSource numberOfColumnsInColumnView:self];
    
    self.contentSize = CGSizeMake([self contentSizeWidth], self.bounds.size.height);
    
    [self calculateAllItemsOrigin];
}


- (void)calculateItemIndexRange {
    float lowerBound = MAX(self.contentOffset.x, 0);
    float upperBound = MIN(self.contentOffset.x + self.bounds.size.width, self.contentSize.width);
    //NSLog(@"lowerBound:%f upperBound:%f", lowerBound, upperBound);
    
    for (int i = 0; i < numberOfColumns; i++) {
        if ([[originPointList objectAtIndex:i] floatValue] <= lowerBound) {
            startIndex = i;
        }
        
        if ([[originPointList objectAtIndex:i] floatValue] < upperBound) {
            endIndex = i;
        }
    }
    
}


- (void)addSubviewsOnScreen {
    [self calculateItemIndexRange];
    
    //S alex
    if (numberOfColumns==0) {
        return;
    }
    //E alex
	
    for (NSNumber *key in [onScreenViewDic allKeys]) {
        if ([key intValue] < startIndex || [key intValue] > endIndex) {
            UITableViewCell *cell = [onScreenViewDic objectForKey:key];
            
            if ([[offScreenViewDic allKeys] containsObject:cell.reuseIdentifier]) {
                NSMutableSet *viewSet = [offScreenViewDic objectForKey:cell.reuseIdentifier];
                [viewSet addObject:cell];
            }else {
                NSMutableSet *newSet = [NSMutableSet setWithObject:cell];
                [offScreenViewDic setObject:newSet forKey:cell.reuseIdentifier];
            }
            
            [onScreenViewDic removeObjectForKey:key];
            [cell removeFromSuperview];
        }
    }
    
    for (int i = startIndex; i < endIndex + 1; i++) {
        if (![[onScreenViewDic allKeys] containsObject:[NSNumber numberWithInt:i]]) {
            UITableViewCell *viewCell = [viewDataSource columnView:self viewForColumnAtIndex:i];
            [onScreenViewDic setObject:viewCell forKey:[NSNumber numberWithInt:i]];
            
            //alex start
            if (selectedIndex==i) {
                [viewCell setSelected:YES animated:YES];
            }else {
                [viewCell setSelected:NO animated:YES];
            }
            //alex end
            
            float viewWidth = [viewDelegate columnView:self widthForColumnAtIndex:i];
            float viewOrigin = [[originPointList objectAtIndex:i] floatValue];
            viewCell.frame = CGRectMake(viewOrigin, 0, viewWidth, self.bounds.size.height);
            [self addSubview:viewCell];
        }
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //NSLog(@"%s", __FUNCTION__);
    
    if (numberOfColumns == 0) {
    	numberOfColumns = viewDataSource == nil ? 0: [viewDataSource numberOfColumnsInColumnView:self];
    }
    //NSLog(@"column count:%d", numberOfColumns);
    //S alex
    if (numberOfColumns==0) {
        return;
    }
    //E alex
    
    if (self.contentSize.width == 0) {
        self.contentSize = CGSizeMake([self contentSizeWidth], self.bounds.size.height);
    }
    
    if ([originPointList count] == 0 && numberOfColumns != 0) {
        [self calculateAllItemsOrigin];
    }
    
    [self addSubviewsOnScreen];
}

//alex new
- (UITableViewCell *)columnForRowAtIndex:(NSUInteger)index{
    return [onScreenViewDic objectForKey:[NSNumber numberWithInt:index]];
}
//alex end


//alex new
- (void)setSelectedColumn:(NSUInteger)index{
    selectedIndex=index;
    for (NSNumber *number in onScreenViewDic.allKeys) {
       UITableViewCell *cell=[onScreenViewDic objectForKey:number];
        if (index==[number integerValue]) {
            [cell setSelected:YES animated:YES];
        }else 
            [cell setSelected:NO animated:YES];
    }
}


#pragma mark -
#pragma mark UIScrollViewDelegate method implementation
//alex
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {    
    /* 代理传递*/
    if (viewDelegate!=nil&&[viewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [viewDelegate scrollViewDidScroll:self];
    }

}


#pragma mark -
#pragma mark UIEvent Handle method
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
    NSLog(@"用户点击了scroll上的视图%@,是否开始滚动scroll",view);
    if (event.type == UIEventTypeTouches) {
        UITouch *touch = (UITouch *)[touches anyObject];
        
        CGPoint point = [touch locationInView:self];
        NSLog(@"point in self:%@", NSStringFromCGPoint(point));
        
        float viewWidth = 0;
        for (int i = 0; i < [viewDataSource numberOfColumnsInColumnView:self]; i++) {
            if (viewWidth < point.x &&
                (viewWidth + [viewDelegate columnView:self widthForColumnAtIndex:i]) > point.x) {
                [viewDelegate columnView:self didSelectColumnAtIndex:i];
                
                //alex start
                [self setSelectedColumn:i];
                //alex end
                
                break;
            }else {
                viewWidth += [viewDelegate columnView:self widthForColumnAtIndex:i];
            }
            
        }
    }
    
    /*S alex*/
    //default YES
    BOOL ret=[super touchesShouldBegin:touches withEvent:event inContentView:view];
    return ret;
    /*E alex*/
}

/*S alex*/
//touchesShouldCancelInContentView: 开始发送tracking messages消息给subview的时候调用这个方法，决定是否发送tracking messages消息到subview。
- (BOOL)touchesShouldCancelInContentView:(UIView *)view 
{
    //NSLog(@"touchesShouldCancelInContentView %@",view);
    //view是UIControl,default NO,非UIControl，default YES
    BOOL ret=[super touchesShouldCancelInContentView:view];
    
    /* 当view是UIControl及view.tag=10086时,subview上的拖动事件由subview处理,scrollView不做响应*/
    if (view.tag==10086) {
        ret=NO;
    }
    
    return ret;    
}
/*E alex */



#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [onScreenViewDic removeAllObjects];
    [offScreenViewDic removeAllObjects];
    
    [onScreenViewDic release];
    [offScreenViewDic release];
    
    [itemDataList release];
    [originPointList release];
    
    [super dealloc];
}

#pragma mark custom
-(void)setPageIndex:(int)pageIndex animated:(BOOL)animated{    
    //改变值
    //_pageIndex=pageIndex;
    [self setContentOffset:CGPointMake(pageIndex*self.frame.size.width, 0) animated:animated];
}




@end
