//
//  BaseController.m
//  BRSD
//
//  Created by Alex on 12-11-22.
//
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


// margin added to back button
#define kBackButtonMarginRight      7.0f
// padding added to back button
#define kBackButtonPadding          10.0f
-(void)setBackButtonTitle:(NSString*)title{
    UIImage *image = [UIImage imageNamed:@"back-button"];
    image = [image stretchableImageWithLeftCapWidth:14.0f topCapHeight:0.0f];
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    
    CGSize textSize = [title sizeWithFont:font];
    CGSize buttonSize = CGSizeMake(textSize.width + kBackButtonPadding * 2, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, buttonSize.width, buttonSize.height)];
    [button addTarget:self action:@selector(didTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button.titleLabel setFont:font];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    
    // defaults are bright to show demo
    // override in viewDidLoad by accessing self.backButton
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithRed:67.0f/255.0f green:3.0f/255.0f blue:38.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    CGFloat margin = floorf((button.frame.size.height - textSize.height) / 2);
    CGFloat marginRight = kBackButtonMarginRight;
    CGFloat marginLeft = button.frame.size.width - textSize.width - marginRight;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(margin, marginLeft, margin, marginRight)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem.leftBarButtonItem setWidth:buttonSize.width];
    //self.backButton = button;
}

@end
