//
//  BaseEntity.m
//  LiveByTouch
//
//  Created by hao.li on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseEntity.h"
#import <objc/runtime.h>

@interface BaseEntity (private)
-(void) toEntity:(NSString*)str;

@end

@implementation BaseEntity

-(id) init{
	self = [super init];
	if (self) {
        //self的BaseEntity类型的成员变量进行初始化
        [self propertyBaseEntity];
	}
	return self;
}

#pragma mark custom
//初始化self的BaseEntity类型的成员变量
-(void)propertyBaseEntity{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSArray *propertyAttributes=[[NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
        //className格式如: T@"NSString"
        NSString *className=[[propertyAttributes objectAtIndex:0] stringByReplacingOccurrencesOfString:@"T@" withString:@""];
        className=[className stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        Class class=NSClassFromString(className);
        if ([class isSubclassOfClass:[BaseEntity class]]) {
            BaseEntity *baseEntity =(BaseEntity*)[[class alloc] init];
            [self setValue:baseEntity forKey:propertyName];
        }
    }
    free(properties); 
}


#pragma mark encode/decode
- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int varCount;
    Ivar *vars = class_copyIvarList([self class], &varCount);
    
    for (int i = 0; i < varCount; i++) {
        [encoder encodeObject: object_getIvar(self, vars[i])
                       forKey: [NSString stringWithUTF8String: ivar_getName(vars[i])]];
    }
}

- (id)initWithCoder:(NSCoder *)decoder
{
    unsigned int varCount;
    Ivar *vars = class_copyIvarList([self class], &varCount);
    
    for (int i = 0; i < varCount; i++) {
        NSString *varName = [NSString stringWithUTF8String: ivar_getName(vars[i])];
        object_setIvar(self, vars[i], [decoder decodeObjectForKey: varName]);
    }
    
    return self;
}


@end
