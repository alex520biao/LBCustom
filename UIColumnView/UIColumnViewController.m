//
//  UIColumnViewController.m
//  BRSD
//
//  Created by Alex on 12-11-27.
//
//

#import "UIColumnViewController.h"

@interface UIColumnViewController ()

@end

@implementation UIColumnViewController
@synthesize columnView=_columnView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    _columnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height)];
    _columnView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _columnView.backgroundColor = [UIColor clearColor];
    _columnView.pagingEnabled=YES;
    _columnView.bounces=NO;
    _columnView.viewDataSource=self;
    _columnView.viewDelegate=self;
    [self.view addSubview:_columnView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// In -viewWillAppear:, it reloads the table's data if it's empty. Otherwise, it deselects all rows (with or without animation) if clearsSelectionOnViewWillAppear is YES.
-(void)viewWillAppear:(BOOL)animated{
    if (CGSizeEqualToSize(_columnView.contentSize, CGSizeZero)) {
        [_columnView reloadData];
    }
}

// In -viewDidAppear:, it flashes the table's scroll indicators.
-(void)viewDidAppear:(BOOL)animated{


}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





@end
