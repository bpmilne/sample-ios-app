//
//  ScrollableView.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "ScrollableView.h"

@implementation ScrollableView

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, screenBounds.size.height, 320, screenBounds.size.height - 56);
        self.backgroundColor = [UIColor DwollaDarkGray];
       
        scrollable = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, screenBounds.size.height-100)];
        [scrollable setBackgroundColor:[UIColor DwollaGray]];
        scrollable.contentSize = CGSizeMake(320, 960);
        [self addSubview:scrollable];
        
        nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [nav titleTextAttributes]];
        [titleBarAttributes setValue:[UIFont fontWithName:@"GillSans-Bold" size:16] forKey:UITextAttributeFont];
        [nav setTitleTextAttributes:titleBarAttributes];
        
        UIImage *originalImage = [UIImage imageNamed:@"dw_header.png"];
        // scaling set to 2.0 makes the image 1/2 the size.
        UIImage *scaledImage =
        [UIImage imageWithCGImage:[originalImage CGImage]
                            scale:(originalImage.scale * 2.0)
                      orientation:(originalImage.imageOrientation)];
        [nav setBackgroundImage:scaledImage forBarMetrics:UIBarMetricsDefault];

    }
    return self;
}

-(void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
}

- (void)addTransactions:(NSMutableArray*) transactions withDelegate:(id) del
{
    [scrollable setDelegate:self];
    UINavigationItem* transactions_header = [[UINavigationItem alloc] initWithTitle:@"TRANSACTIONS"];
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 60, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_profileb.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [transactions_header setLeftBarButtonItem:back];
    [nav pushNavigationItem:transactions_header animated:NO];
    [self addSubview:nav];
    
    scrollable.contentSize = CGSizeMake(320, (80*[transactions count])+10);
    
    for (int i = 0; i < [transactions count]; i++)
    {
        TransactionView* transaction = [[TransactionView alloc] init];
        [transaction setDelegate:del];
        
        [transaction addData:[transactions objectAtIndex:i]];
        [transaction shiftView:i];
        [transaction addCommandCenter:command];
        
        [scrollable addSubview:transaction];
    }
}

- (void)insertTransactions:(NSMutableArray*) transactions withDelegate:(id) del offset:(int)offset
{    
    scrollable.contentSize = CGSizeMake(320, (80*[transactions count])+10);
    
    for (int i = offset; i < [transactions count]; i++)
    {
        TransactionView* transaction = [[TransactionView alloc] init];
        [transaction setDelegate:del];
        
        [transaction addData:[transactions objectAtIndex:i]];
        [transaction shiftView:i];
        [transaction addCommandCenter:command];
        
        [scrollable addSubview:transaction];
    }
}

- (void)addRequests:(NSMutableArray*) requests withDelegate:(id) del
{
    scrollable.frame = CGRectMake(0, 40, 320, screenBounds.size.height-40);
    
    int j = 0;
    for (int i = 0; i < [requests count]; i++)
    {
        RequestView* request = [[RequestView alloc] init];
        [request setDelegate:del];
        
        [request addData:[requests objectAtIndex:i]];
        [request setProfile:[command getAvatar:[request dwolla_id]]];
        
        if (![request youRequested])
        {
            [request shiftView:j];
            [scrollable addSubview:request];
            j += 1;
        }
        else
        {
            [request destroy];
            request = nil;
        }
    }
    
    scrollable.contentSize = CGSizeMake(320, (80*j)+25);
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, 20+(screenBounds.size.height - 100)/2);
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, screenBounds.size.height + (screenBounds.size.height-80)/2);
    [UIView commitAnimations];
}

- (void)reset
{
    NSArray* content = [scrollable subviews];
    for (int i = 0; i < [content count]; i++)
    {
        [[content objectAtIndex:i] removeFromSuperview];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint point = scrollView.contentOffset;
    if (point.y >= scrollView.contentSize.height-300)
    {
        [[self delegate] loadTransactions];
    }
}

- (void)destroyTransactions
{

    command = nil;
    [nav removeFromSuperview];
    nav = nil;
    delegate = nil;
    
    NSArray* content = [scrollable subviews];
    for (int i = 0; i < [content count]; i++)
    {
        if (![[content objectAtIndex:i] isKindOfClass:[TransactionView class]])
        {
            UIView* view = [content objectAtIndex:i];
            [view removeFromSuperview];
            view = nil;
        }
        else
        {
            TransactionView* view = [content objectAtIndex:i];
            [view destroy];
            [view removeFromSuperview];
            view = nil;
        }
    }
    [scrollable removeFromSuperview];
    scrollable = nil;
}
@end
