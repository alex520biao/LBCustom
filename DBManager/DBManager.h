//
//  DBManager.h
//  FMDBDemo
//
//  Created by liubiao on 11-3-23.
//  Copyright 2011 艾诗德. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@interface DBManager : NSObject {
	@private
	FMDatabase *_db;//私有成员
}
@property(nonatomic,strong)FMDatabase *db;
+(DBManager*)sharedDBManager;
- (int) openDB;
- (void) closeDB;
@end
