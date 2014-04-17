//
//  DBManagerAdd.m
//  FMDBDemo
//
//  Created by liubiao on 11-3-23.
//  Copyright 2011 艾诗德. All rights reserved.
//

#import "DBManagerAdd.h"
@implementation DBManager(Add)

#pragma mark Feature
-(NSMutableArray*)queryFeatureList
{        
    NSMutableArray *list=[[NSMutableArray alloc] init];
    NSString *sql = @"SELECT * FROM tb_feature";
    FMResultSet *rs = [_db executeQuery:sql];
    while ([rs next]) {
        Feature *feature=(Feature*)[[Feature alloc] initWithFMResultSet:rs];
        if (feature.spotTypeId) {
            //根据spotTypeId获取关联对象spotType
        }
        [list addObject:feature];
    }
    [rs close];
    return list;
}

#pragma mark other



@end
