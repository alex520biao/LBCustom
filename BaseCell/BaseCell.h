//
//  BaseCell.h
//  BRSD
//
//  Created by Alex on 12-11-20.
//
//

#import <UIKit/UIKit.h>
#import "BaseEntity.h"

@interface BaseCell : UITableViewCell
@property(nonatomic,strong) BaseEntity *baseEntity;

+(CGFloat)cellHeight;
+(CGFloat)cellWidth;
+ (BaseCell*)loadWithNibName:(NSString*)nibName reuseIdentifier:(NSString *)reuseIdentifier;
-(void)update_baseEntity_view;
@end
