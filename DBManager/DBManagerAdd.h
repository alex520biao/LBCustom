//
//  DBManagerAdd.h
//  FMDBDemo
//
//  Created by liubiao on 11-3-23.
//  Copyright 2011 艾诗德. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "Feature.h"

/*
 如果时多人协同开发,那么可以创建多个类目DBManager+Add文件，一个类目文件对应一个开发人员的内容,这样不会导致svn冲突;
 */

@interface DBManager(Add)

#pragma mark Feature
-(NSMutableArray*)queryFeatureList;




@end
