//
//  plist.h
//  DrawView
//
//  Created by liubiao on 12/2/09.
//  Copyright 2009 sdie. All rights reserved.
//

#import <Foundation/Foundation.h>

//默认文件格式为plist
//默认存储路径固定
//只有NSArray、NSDictionary、NSData三容器种

/*
 NSDictionary *dict=[Plist plistLoadDict:@"NEW"];
 NSArray *array=[Plist plistLoadDict:@"NEW"];
 */

@interface Plist : NSObject {
	
}
#pragma mark 读取plist文件
+(NSArray*)plistLoadArray:(NSString *)fileName;
+(NSData*)plistLoadData:(NSString *)fileName;
+(NSDictionary*)plistLoadDict:(NSString *)fileName;

#pragma mark 保存plist文件
+(void)plistSaveArray:(NSArray*)array fileName:(NSString*)fileName;
+(void)plistSaveData:(NSData*)data fileName:(NSString*)fileName;
+(void)plistSaveDict:(NSDictionary*)dict fileName:(NSString*)fileName;

#pragma mark plist文件保存路径
+ (NSString*)pathOfPlistFileName:(NSString *)fileName;
@end


