//
//  FVSeq2View.h
//  PURE HILL
//
//  Created by mac on 13-1-21.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FVImageSequence.h"
#import "ItemObj.h"
#import "FVSeqScrollView.h"
@interface FVSeq2View : UIView

@property(nonatomic,strong)FVImageSequence *seqImageView;
@property(nonatomic,strong)FVSeqScrollView *seqScrollView;

@property(strong,nonatomic)UIImageView *backgroundView;
@property(strong,nonatomic)UIImageView *overlayView;
@property(strong,nonatomic)UIView *leftView;
@property(strong,nonatomic)UIView *rightView;
@property(strong,nonatomic)UIImageView *leftImgView;
@property(strong,nonatomic)UIImageView *rightImgView;
@property(strong,nonatomic)NSMutableArray *btnList;//动态按钮


@property(strong,nonatomic)ItemObj *itemObj;
@property(assign,nonatomic)int indexType;//0首位 1中间 2末尾 
@property(strong,nonatomic)NSMutableDictionary *imgDataDict;
@property(strong,nonatomic)NSArray *btnDataList;//动态按钮的位置信息



@end
