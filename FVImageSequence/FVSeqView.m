//
//  FVSeqView.m
//  PURE HILL
//
//  Created by mac on 13-1-21.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FVSeqView.h"

@implementation FVSeqView
@synthesize seqImageView=_seqImageView;
@synthesize itemObj=_itemObj;
@synthesize backgroundView=_backgroundView;
@synthesize overlayView=_overlayView;
@synthesize leftView=_leftView;
@synthesize rightView=_rightView;
@synthesize leftImgView=_leftImgView;
@synthesize rightImgView=_rightImgView;
@synthesize btnList=_btnList;


@synthesize imgDataDict=_imgDataDict;
@synthesize btnDataList=_btnDataList;
@synthesize indexType=_indexType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds=YES;//超出contentView的内容不显示
        
        [self addObserver:self forKeyPath:@"itemObj" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"btnDataList" options:NSKeyValueObservingOptionNew context:nil];

        
        /*背景层*/
        UIImageView *backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.itemObj.backgroundImg]];
        backgroundView.frame=self.bounds;
        [self addSubview:backgroundView];  
        self.backgroundView=backgroundView;
        
        /* ImageSequence  */ 
        FVImageSequence *imageSquence=[[FVImageSequence alloc] initWithFrame:self.bounds];
        imageSquence.tag=10086;//表示将会获取事件
        [imageSquence setPrefix:self.itemObj.imgSeq.prefix firstIndex:self.itemObj.imgSeq.firstIndex lastIndex:self.itemObj.imgSeq.lastIndex extension:self.itemObj.imgSeq.extension];
        imageSquence.cycle=self.itemObj.imgSeq.cycle;//图片是否循环
        imageSquence.backgroundColor=[UIColor clearColor];
        //imageSquence.center=CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2);
        imageSquence.clipsToBounds=YES;
        [self addSubview:imageSquence];
        imageSquence.hidden=YES;
        self.seqImageView=imageSquence;  
                
        /*叠加层*/
        UIImageView *overlayView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.itemObj.overlayImg]];
        overlayView.frame=self.bounds;
        overlayView.tag=999;
        overlayView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:overlayView];
        self.overlayView=overlayView;
        
        
        /* left/right view*/
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 670)];
        self.leftView=leftView;
        [self addSubview:leftView];
        UIImageView *leftImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 53)];
        leftImgView.center=CGPointMake(leftView.frame.size.width/2, leftView.frame.size.height/2);
        leftImgView.image=[UIImage imageNamed:@"左.png"];
        [leftView addSubview:leftImgView];
        _leftImgView=leftImgView;

        
        UIView *rightView=[[UIView alloc] initWithFrame:CGRectMake(924, 0, 100, 670)];
        self.rightView=rightView;
        [self addSubview:rightView];
        UIImageView *rightImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 53)];
        rightImgView.center=CGPointMake(rightView.frame.size.width/2, rightView.frame.size.height/2);
        rightImgView.image=[UIImage imageNamed:@"右.png"];
        [rightView addSubview:rightImgView];
        _rightImgView=rightImgView;        
    }
    return self;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"itemObj"];
    [self removeObserver:self forKeyPath:@"btnDataList"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setImgDataDict:(NSMutableDictionary *)imgDataDict{
    _imgDataDict=imgDataDict;

    /*动态按钮*/
    if (_btnList==nil) {
        _btnList=[[NSMutableArray alloc] init];
        NSArray *firstList=[_imgDataDict objectForKey:[NSString stringWithFormat:@"%d",self.itemObj.imgSeq.firstIndex]];
        for (int i=0; i<firstList.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectZero;
            btn.tag=i;
            [self addSubview:btn];
            [_btnList addObject:btn];
        }
        
        [_seqImageView setPicNameAtIndexBlock:^(NSString *picName, NSUInteger index) {
            NSArray *btnList=[self.imgDataDict objectForKey:[NSString stringWithFormat:@"%d",index]];
            self.btnDataList=btnList;//KVO更新界面
        }];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}

#pragma mark NSKeyValueObserving
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /*数据模型修改调用update_obj_view*/
    if ([keyPath isEqualToString:@"itemObj"]) {
        [self performSelectorOnMainThread:@selector(update_itemObj_view) withObject:nil waitUntilDone:NO];
    }else if([keyPath isEqualToString:@"btnDataList"]){
        [self performSelectorOnMainThread:@selector(update_btnDataList_view) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark KVO-UpdateView
-(void)update_itemObj_view{
    if (_itemObj.backgroundImg) {
        //self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:_itemObj.backgroundImg]];
        self.backgroundView.image=[UIImage imageNamed:_itemObj.backgroundImg];
    }else {
        //self.backgroundColor=[UIColor clearColor];
        self.backgroundView.image=nil;
    }
    
    if (_itemObj.imgSeq.prefix) {
        [_seqImageView setPrefix:_itemObj.imgSeq.prefix firstIndex:_itemObj.imgSeq.firstIndex lastIndex:_itemObj.imgSeq.lastIndex extension:self.itemObj.imgSeq.extension];
        [_seqImageView setCycle:_itemObj.imgSeq.cycle];
        _seqImageView.hidden=NO;
    }else {
        _seqImageView.hidden=YES;
    }
    
    if (_itemObj.preNext) {
        //_leftView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"左.png"]];
        //_rightView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"右.png"]];
        _leftImgView.hidden=NO;
        _rightImgView.hidden=NO;
    }else {
        _leftView.backgroundColor=[UIColor clearColor];
        _rightView.backgroundColor=[UIColor clearColor];
        _leftImgView.hidden=YES;
        _rightImgView.hidden=YES;
    }
    
    if (_indexType==0) {
        _leftImgView.hidden=YES;
        _rightImgView.hidden=NO;
    }else if(_indexType==1){
        _leftImgView.hidden=NO;
        _rightImgView.hidden=NO;
    }
    else if(_indexType==2){
        _leftImgView.hidden=NO;
        _rightImgView.hidden=YES;
    }
    
    _overlayView.image=[UIImage imageNamed:_itemObj.overlayImg];
    _overlayView.frame=self.bounds;//必须重新设置overlayView的frame
}

-(void)update_btnDataList_view{
    for (int i=0; i<[_btnDataList count]; i++) {
        UIButton *btn=[self.btnList objectAtIndex:i];
        NSDictionary *btnDict=[_btnDataList objectAtIndex:i];
        CGRect rect= CGRectFromString([btnDict objectForKey:@"btnRect"]);
        btn.frame=rect;
        //[btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        //NSLog(@"XXXXX:%@",NSStringFromCGRect(rect));
    }
}



@end
