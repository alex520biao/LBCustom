//
//  BaseController.h
//  BRSD
//
//  Created by Alex on 12-11-22.
//
//

#import <UIKit/UIKit.h>

/*数据处理库*/
#import "JSON.h"

/*数据模型*/
#import "ItemObj.h"
#import "Feature.h"
#import "ImgSeq.h"

/*import 数据管理类*/
#import "Plist+Add.h"//plist数据管理
#import "DBManagerAdd.h"//DB数据管理
//JSON数据管理
//XML数据管理



/*
 BaseController封装了网络访问及其相关处理(进度提示等)
 还有就是navigationBar上的通用按钮
 如果开发中有如下需求,那么我们应该子类化BaseController,它将减少很多重复代码
 */
@interface BaseController : UIViewController{
    //进度提示
    
    //信息提示
    
    //常用网络访问
    
    //NavigationBar上的固定按钮:back(返回),home(主页),refresh(刷新),这几个都是navigationBar上的通用按钮
    
     NSString *_backButtonTitle;
    
}
-(void)setBackButtonTitle:(NSString*)title;
@end
