//
//  Plist+Add.h
//  BRSD
//
//  Created by Alex on 12-11-26.
//
//

#import "Plist.h"
#import "ItemObj.h"
#import "Feature.h"
#import "ImgSeq.h"
@interface Plist (Add)

/*
 plist文件中每项的数据类型必须要和自定义类属性的数据类型完全匹配,否则解析会报错
 1.引入文件
 #import "Plist+Add.h"
 2.加载数据
 NSMutableArray *list1=[Plist plistLoadItemList];
 
 如果时多人协同开发,那么可以创建多个类目Plist+Add文件，一个类目文件管理一个plist文件,由一个开发人员创建并管理,这样不会导致svn冲突;
 总之，可以按照开发人员分配任务划分类目，也可以按照plist文件来划分类目;
 如果整个程序只有一个plist文件且只有一个开发者,那么创建一个Plist类目文件即可;
*/

#pragma mark itemList
+(NSMutableArray*)plistLoadItemList;

#pragma mark other
@end
