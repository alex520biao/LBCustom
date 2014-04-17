//
//  ImgSeq.h
//  BRSD
//
//  Created by mac on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

//图片序列类
@interface ImgSeq : BaseEntity
@property(nonatomic,strong)NSString *prefix;//图片前缀
@property(nonatomic,assign)int firstIndex;
@property(nonatomic,assign)int lastIndex;
@property(nonatomic,strong)NSString *extension;//图片文件类型
@property(nonatomic,assign)BOOL cycle;//图片序列是否循环

@end
