//
//  BaseEntity+FMDB.m
//  BRSD
//
//  Created by Alex on 12-11-22.
//
//

#import "BaseEntity+FMDB.h"
#import <objc/runtime.h>

@implementation BaseEntity (FMDB)

-(id) initWithFMResultSet:(FMResultSet*)set{
	self = [super init];
	if (self) {        
        [self toEntityWithRS:set];
	}
	return self;
}

//通过FMResultSet给对象赋值
-(void) toEntityWithRS:(FMResultSet*)set
{
	if (set == nil)
		return;
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSArray *propertyAttributes=[[NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
        //columnType格式如: T@"NSString"
        NSString *columnType=[[propertyAttributes objectAtIndex:0] stringByReplacingOccurrencesOfString:@"T" withString:@""];
        columnType=[columnType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        columnType=[columnType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [self setObjWithFMResultSet:set column:propertyName columnType:columnType];
    }
    free(properties);
}

-(void)setObjWithFMResultSet:(FMResultSet*)set column:(NSString*)columnName columnType:(NSString*)columnType{
    //FMResultSet的数据类型:NSString,BOOL,Char,double,float,int,NSInteger,long,long long,NSDate,NSData
    if ([columnType isEqualToString:@"NSString"]) {//NSSTring
        NSString *value= [set stringForColumn:columnName];
        [self setValue:[value copy] forKey:columnName];//字符串的值要使用copy
    }
    else if([columnType isEqualToString:@"c"]){//BOOL
        BOOL  value=[set boolForColumn:columnName];
        NSNumber *number=[NSNumber numberWithBool:value];
        [self setValue:[number copy] forKey:columnName];
    }
    else if([columnType isEqualToString:@"d"]){//double
        double  value=[set doubleForColumn:columnName];
        NSNumber *number=[NSNumber numberWithDouble:value];
        [self setValue:[number copy] forKey:columnName];
    }
    else if([columnType isEqualToString:@"f"]){//float
        float  value=[set doubleForColumn:columnName];
        NSNumber *number=[NSNumber numberWithFloat:value];
        [self setValue:[number copy] forKey:columnName];
    }
    else if([columnType isEqualToString:@"i"]){//int
        int  value=[set intForColumn:columnName];
        NSNumber *number=[NSNumber numberWithInt:value];
        [self setValue:[number copy] forKey:columnName];
    }
    else if([columnType isEqualToString:@"long"]||[columnType isEqualToString:@"long long"]){
        long  value=[set longForColumn:columnName];
        NSNumber *number=[NSNumber numberWithLong:value];
        [self setValue:[number copy] forKey:columnName];
    }
    //对象的自定义类型的属性不能自动加载数据，需要手动加载
}

@end





