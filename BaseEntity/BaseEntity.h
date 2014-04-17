//
//  BaseEntity.h
//  LiveByTouch
//
//  Created by hao.li on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
	ActionDeSave=0,//取消收藏
	ActionSave=1,//保存
}ActionType;

typedef enum{
	FavoriteShanghu=1,//商户收藏
	FavoriteReview=2,//收藏评论信息
}FavoriteType;

@interface BaseEntity : NSObject {

}

-(id) init;

@end




