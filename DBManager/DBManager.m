//
//  DBManager.m
//  FMDBDemo
//
//  Created by liubiao on 11-3-23.
//  Copyright 2011 艾诗德. All rights reserved.
//

#import "DBManager.h"
#define kMainDB @"guide.db"

@implementation DBManager
@synthesize db=_db;

static DBManager* sharedDBManager=nil;
+(DBManager*)sharedDBManager
{
	@synchronized(sharedDBManager) //单多线程访问
	{
		if (!sharedDBManager) //sharedSQL为nil则新建
		{
			sharedDBManager=[[DBManager alloc] init];//创建
			[sharedDBManager openDB];//开启数据库对象
		}
	}
	return sharedDBManager;
}


- (int) openDB {    
    NSString *DBPath=[self createDatabaseIfNeeded];
    NSLog(@"%@",DBPath);
    self.db = [FMDatabase databaseWithPath:DBPath];
    if (![_db open]) {
		NSLog(@"Could not open db.");
    }
	return 0;
        
}



- (void) closeDB {
	[_db close];
}

//获取数据库路径
-(NSString*)createDatabaseIfNeeded
{
    NSFileManager *filemanage=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *dstPath =[documentsDirectory stringByAppendingPathComponent:kMainDB];
    BOOL sucess=[filemanage fileExistsAtPath:dstPath];
    if (!sucess) {
        NSString *srcPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kMainDB];
        NSError *error;
        sucess=[filemanage copyItemAtPath:srcPath toPath:dstPath  error:&error];
        if (!sucess) {
            NSLog(@"create Database rror:%@",[error localizedDescription]);
        }
    }
    return dstPath;
}



@end
