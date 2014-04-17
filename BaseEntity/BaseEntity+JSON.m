//
//  BaseEntity+JSON.m
//  BRSD
//
//  Created by Alex on 12-11-22.
//
//

#import "BaseEntity+JSON.h"
#import <objc/runtime.h>

@implementation BaseEntity (JSON)

//通过jsonStr创建BaseEntity对象
-(id) initWithJSONStr:(NSString*)str{
	self = [super init];
	if (self) {
		[self toEntityWithStr:str];
	}
	return self;
}

//通过NSDictionary创建BaseEntity对象
-(id) initWithDicionary:(NSDictionary*)dict{
	self = [self init];
	if (self) {
		[self toEntityWithDict:dict];
	}
	return self;
}


- (NSString*) toJson{
	NSString *jsonString = [[self properties_aps] JSONRepresentation];
	return jsonString;
}

- (NSDictionary *)properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
		//NSLog(@"名称:%@--值:%@---属性:%@",propertyName,propertyValue,attr);
		if ([propertyValue isKindOfClass:[BaseEntity class]]) {
			BaseEntity *subClass = (BaseEntity*)propertyValue;
			propertyValue = [[subClass toJson] JSONValue];
		}
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

#pragma mark private
//通过jsonStr给对象赋值
-(void) toEntityWithStr:(NSString*)jsonStr
{
	if (jsonStr == nil||[jsonStr isEqualToString:@""])
    {
		return;
	}
    NSDictionary *dict=(NSDictionary*)[jsonStr JSONValue];
    [self toEntityWithDict:dict];
}

//通过NSDictionary给对象赋值
-(void) toEntityWithDict:(NSDictionary*)dict
{
	if (dict == nil)
    {
		return;
	}    
	unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSArray *propertyAttributes=[[NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
        //property_getName()返回属性的名字 在Foo中分别是 property1和property2
        //property_getAttributes()返回此对象属性的属性，如是retain还是copy之类的
        //这个方法输出了该类所有的属性名与此属性的属性（好绕口啊）
        //NSLog(@"%s %s\n", property_getName(property), property_getAttributes(property));
        //NSLog(@"propertyname=%@",propertyName);
        //NSLog(@"propertyAttributes=%@",propertyAttributes);
        
        id propertyObj=[dict objectForKey:propertyName];//dict中的propertydict的值
        id propertyValue = [self valueForKey:propertyName];//self中的property当前值

        //className格式如: T@"NSString"
        NSString *className=[[propertyAttributes objectAtIndex:0] stringByReplacingOccurrencesOfString:@"T@" withString:@""];
        className=[className stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        Class class=NSClassFromString(className);
        if ([class isSubclassOfClass:[BaseEntity class]]) {
            BaseEntity *baseEntity=(BaseEntity*)propertyValue;
            if (!baseEntity) {//如果对象的propertyValue为nil,那么我们需要初始化对象
                baseEntity =[[class alloc] init];
            }
            
            [baseEntity toEntityWithDict:propertyObj];
            [self setValue:baseEntity forKey:propertyName];
        }
        else {
            if (propertyObj == [NSNull null]) {
                // Do something for a null
                //NSLog(@"haha=%@",propertyObj);
            }
            else if(propertyObj!=nil&&propertyObj!=@"") {
                [self setValue:propertyObj forKey:propertyName];
            }
        }

    }
    free(properties);
}






@end
