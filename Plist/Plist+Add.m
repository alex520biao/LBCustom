//
//  Plist+Add.m
//  BRSD
//
//  Created by Alex on 12-11-26.
//
//

#import "Plist+Add.h"

@implementation Plist (Add)

#pragma mark itemList
+(NSMutableArray*)plistLoadItemList{
    NSMutableArray *itemList=[[NSMutableArray alloc] init];
    NSArray *list=[self plistLoadArray:@"itemList"];
    for (int i=0; i<list.count; i++) {
        ItemObj *obj=[[ItemObj alloc] initWithDicionary:[list objectAtIndex:i]];
        [itemList addObject:obj];
        NSLog(@"itemCode:%@",obj.itemCode);
    }
    return itemList;
}

#pragma mark other


@end
