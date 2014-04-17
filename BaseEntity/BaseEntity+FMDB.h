//
//  BaseEntity+FMDB.h
//  BRSD
//
//  Created by Alex on 12-11-22.
//
//

#import "BaseEntity.h"
#import "FMDatabase.h"
/*
 依赖于FMDB
 只支持基本数据类型:NSString,int.float,double,long,BOOL,Date,
 */
@interface BaseEntity (FMDB)
-(id) initWithFMResultSet:(FMResultSet*)set;
-(void) toEntityWithRS:(FMResultSet*)set;
@end
