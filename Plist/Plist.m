//
//  plist.m
//  DrawView
//
//  Created by liubiao on 12/2/09.
//  Copyright 2009 sdie. All rights reserved.
//

#import "Plist.h"

@implementation Plist 
#pragma mark #pragma mark public
//所有plist文件存放到此目录下
+(NSString*)pathOfPlistFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//documents目录
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
}

#pragma mark 读取plist文件
+(NSArray*)plistLoadArray:(NSString *)fileName{
    NSArray *data;
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSString *filePath = [Plist pathOfPlistFileName:fileName];
    //将plist文件从NSBundle拷贝到沙盒中
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            if ( [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil]) {
                //从filePath读取plist得到id对象
                data=[[NSArray alloc ] initWithContentsOfFile:filePath];
            }
        }else{
            NSLog(@"%@.plist is not exist in mainBundle",fileName);
        }
    }else{
        //从filePath读取plist得到id对象
        data=[[NSArray alloc ] initWithContentsOfFile:filePath];
    }
    return data;
}

+(NSDictionary*)plistLoadDict:(NSString *)fileName{
    NSDictionary *data;
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSString *filePath = [Plist pathOfPlistFileName:fileName];
    //将plist文件从NSBundle拷贝到沙盒中
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            if ( [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil]) {
                //从filePath读取plist得到id对象
                data=[[NSDictionary alloc ] initWithContentsOfFile:filePath];
            }
        }else{
            NSLog(@"%@.plist is not exist in mainBundle",fileName);
        }
    }
    return data;
}

+(NSData*)plistLoadData:(NSString *)fileName{
    NSData *data;
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSString *filePath = [Plist pathOfPlistFileName:fileName];
    //将plist文件从NSBundle拷贝到沙盒中
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            if ( [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil]) {
                //从filePath读取plist得到id对象
                data=[[NSData alloc ] initWithContentsOfFile:filePath];
            }
        }else{
            NSLog(@"%@.plist is not exist in mainBundle",fileName);
        }
    }
    return data;
}

#pragma mark 保存plist文件
+(void)plistSaveArray:(NSArray*)array fileName:(NSString*)fileName
{
	//NSArray数据以plist文件保存到沙盒中
    NSString *filePath = [Plist pathOfPlistFileName:fileName];
    if (![array writeToFile:filePath atomically:YES]) {
        NSLog(@"%@.plist save is failed!",fileName);
    }
}

+(void)plistSaveData:(NSData*)data fileName:(NSString*)fileName
{
	//NSData数据以plist文件保存到沙盒中
    NSString *filePath = [Plist pathOfPlistFileName:fileName];
    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"%@.plist save is failed!",fileName);
    }
}

+(void)plistSaveDict:(NSDictionary*)dict fileName:(NSString*)fileName{
    //NSDictionary数据以plist文件保存到沙盒中
    NSString *filePath = [Plist pathOfPlistFileName:fileName];
    if (![dict writeToFile:filePath atomically:YES]) {
        NSLog(@"%@.plist save is failed!",fileName);
    }
}

@end

