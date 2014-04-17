//
//  BaseCell.m
//  BRSD
//
//  Created by Alex on 12-11-20.
//
//

#import "BaseCell.h"

@implementation BaseCell
@synthesize baseEntity=_baseEntity;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"baseEntity"];
}

#pragma mark customs
+(CGFloat)cellHeight{
    return 30;
}

+(CGFloat)cellWidth{
    return 30;
}

+ (BaseCell*)loadWithNibName:(NSString*)nibName reuseIdentifier:(NSString *)reuseIdentifier{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    if (array.count==0) {
        return nil;
    }
    BaseCell *cell=[array objectAtIndex:0];
    if (cell) {
        [cell setValue:reuseIdentifier forKey:@"reuseIdentifier"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //模型添加键值观察
        [cell addObserver:cell forKeyPath:@"baseEntity" options:NSKeyValueObservingOptionNew context:nil];
    }
    return cell;
}


#pragma mark NSKeyValueObserving
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /*数据模型修改调用update_obj_view*/
    if ([keyPath isEqualToString:@"baseEntity"]) {
        [self performSelectorOnMainThread:@selector(update_baseEntity_view) withObject:nil waitUntilDone:NO];
    }
}

#pragma mark KVO-UpdateView
-(void)update_baseEntity_view{
    NSLog(@"update_baseEntity_view");
}

@end
