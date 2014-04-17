//
//  ItemObj.h
//  BRSD
//
//  Created by mac on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "ImgSeq.h"

@interface ItemObj : BaseEntity 
@property(nonatomic,strong)NSString *itemCode;//对象唯一code(字符串)
@property(nonatomic,strong)NSString *itemCategory;
@property(nonatomic,strong)NSString *itemTitle;
@property(nonatomic,strong)NSString *itemImage;

@property(nonatomic,strong)ImgSeq *imgSeq;

@property(nonatomic,strong)NSString *overlayImg;
@property(nonatomic,strong)NSString *backgroundImg;
@property(nonatomic,strong)NSString *finger;
@property(nonatomic,assign)BOOL preNext;
@property(nonatomic,strong)NSString *zoomScrollImg;

//内容图片
@property(nonatomic,strong)NSString *contentImg;





@end
