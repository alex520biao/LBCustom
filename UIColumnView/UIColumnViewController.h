//
//  UIColumnViewController.h
//  BRSD
//
//  Created by Alex on 12-11-27.
//
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "BaseController.h"

@interface UIColumnViewController : BaseController<UIColumnViewDelegate, UIColumnViewDataSource>{

}
@property(nonatomic,retain)UIColumnView *columnView;

@end
