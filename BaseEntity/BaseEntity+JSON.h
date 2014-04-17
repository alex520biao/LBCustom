//
//  BaseEntity+JSON.h
//  BRSD
//
//  Created by Alex on 12-11-22.
//
//

#import "BaseEntity.h"
#import "JSON.h"
/*
 依赖于SBJSON
 */
@interface BaseEntity (JSON)
-(id) initWithJSONStr:(NSString*)str;
-(id) initWithDicionary:(NSDictionary*)dict;
- (NSDictionary *)properties_aps;
- (NSString*) toJson;
@end
