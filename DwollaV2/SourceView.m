//
//  SourceView.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/23/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "SourceView.h"

@implementation SourceView

@synthesize delegate;
@synthesize source_id;
@synthesize source_name;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(-320, 0, 320, screenBounds.size.height);
        self.backgroundColor = [UIColor clearColor];
        
        content = [[RoundedView alloc] initWithFrame:CGRectMake(10, 10, 300, 190)];
        content.backgroundColor = [UIColor whiteColor];
        
        header = [[BoldTextView alloc] initWithFrame:CGRectMake(35, 10, 235, 30)];
        [header setText:@"DEPOSIT SOURCE"];
        [header setFont:[UIFont fontWithName:@"GillSans-Bold" size:13]];
        header.textAlignment = NSTextAlignmentCenter;
        [content addSubview:header];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [content addSubview:dash];
        
        transfer_text = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, 280, 60)];
        [transfer_text setBackgroundColor:[UIColor clearColor]];
        transfer_text.textAlignment = NSTextAlignmentCenter;
        [transfer_text setTextColor:[UIColor DwollaDarkGray]];
        [transfer_text setUserInteractionEnabled:NO];
        [transfer_text setFont:[UIFont fontWithName:@"GillSans" size:16]];
        [transfer_text setText:@"Choose a source to fund the deposit into your Dwolla account."];
        [content addSubview:transfer_text];
        
        close_source = [[UIButton alloc] initWithFrame:CGRectMake(265, 15, 20, 20)];
        close_source.backgroundColor = [UIColor clearColor];
        [close_source setImage:[UIImage imageNamed:@"dw_x.png"] forState:UIControlStateNormal];
        [close_source addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [content addSubview:close_source];
        
        back = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
        [back setImage:[UIImage imageNamed:@"dw_back.png"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        back.backgroundColor = [UIColor clearColor];
        [content addSubview:back];
        
        [self addSubview:content];
    }
    return self;
}

- (void)populateWithSources:(NSMutableArray*)_sources
{
    sources = _sources;
    int content_height = 150 + (40 * [sources count]);
    content.frame = CGRectMake(10, 10, 300, content_height);
    
    for (int i = 0; i < [_sources count]; i++)
    {
        
        source_select = [[UIButton alloc] initWithFrame:CGRectMake(10, 140 + (38 * i), 280, 40)];
        [source_select setBackgroundImage:[UIImage imageNamed:@"dw_source.png"] forState:UIControlStateNormal];
        [source_select setBackgroundColor:[UIColor clearColor]];
        source_select.titleLabel.font = [UIFont fontWithName:@"GillSans" size:14];
        [source_select setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        [source_select setTitle:[[sources objectAtIndex:i] name] forState:UIControlStateNormal];
        [source_select addTarget:self action:@selector(selectSource:) forControlEvents:UIControlEventTouchUpInside];
        source_select.tag = i;
        
        [content addSubview:source_select];
    }
}

- (void)selectSource:(UIButton*)sender
{
    source_id = [[sources objectAtIndex:sender.tag] source_id];
    source_name = [[sources objectAtIndex:sender.tag] name];
    [[self delegate] showPin];
}

- (void)setAsDeposit
{
    [header setText:@"DEPOSIT SOURCE"];
    [transfer_text setText:@"Choose a source to fund the deposit into your Dwolla account."];
}

- (void)setAsWithdraw
{
    [header setText:@"WITHDRAWAL DESTINATION"];
    [transfer_text setText:@"Choose a destination for the withdrawal from your Dwolla account."];
}

- (void)close
{
    [[self delegate] hideTransfer];
}

- (void)destroy
{
    NSArray* subviews = [self subviews];
    
    for (int i = 0; i < [subviews count]; i++)
    {
        UIView* view = [subviews objectAtIndex:i];
        [view removeFromSuperview];
        view = nil;
    }
    
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, screenBounds.size.height/2);
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(-480, screenBounds.size.height/2);
    [UIView commitAnimations];
    [[self delegate ]showMain];
}

@end
