//
//  FVSeqZoomView.h
//  PURE HILL
//
//  Created by Alex on 13-1-28.
//
//

#import "ZoomImgScrollView.h"
#import "FVImageSequence.h"
#import "ItemObj.h"

@interface FVSeqScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong)FVImageSequence *imageSequence;

-(void)setItemObj:(ItemObj*)itemObj;

@end
