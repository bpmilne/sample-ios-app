//
//  SlipViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/22/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "SlipView.h"

@interface SlipView ()

@end

@implementation SlipView

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(-320, 0, 320, 480);
        self.backgroundColor = [UIColor DwollaClearGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 10, 300, 290)];
        top.backgroundColor = [UIColor whiteColor];
        [self addSubview:top];
        
        profile = [[RoundedImageView alloc] initWithFrame:CGRectMake(166, 20, 50, 50)];
        [top addSubview:profile];
        
        bank_img = [[RoundedImageView alloc] initWithFrame:CGRectMake(104, 20, 50, 50)];
        [bank_img setImage:[UIImage imageNamed:@"dw_bank.png"]];
        [top addSubview:bank_img];
        
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(142, 36, 20, 20)];
        [arrow setImage:[UIImage imageNamed:@"dw_arrow.png"]];
        [top addSubview:arrow];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(70, 65, 160, 25)];
        name.textAlignment = NSTextAlignmentCenter;
        [top addSubview:name];
        
        timebg = [[UIImageView alloc] initWithFrame:CGRectMake(55, 90, 190, 25)];
        timebg.image = [UIImage imageNamed:@"dw_timebanner.png"];
        [timebg setBackgroundColor:[UIColor clearColor]];
        [top addSubview:timebg];
        
        time = [[BoldTextView alloc] initWithFrame:CGRectMake(70, 86, 180, 25)];
        [time setTextColor:[UIColor whiteColor]];
        [top addSubview:time];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 135, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash];
        
        total = [[BoldTextView alloc] initWithFrame:CGRectMake(10, 140, 100, 25)];
        [total setText:@"TOTAL"];
        [top addSubview:total];
        
        amount = [[LightTextView alloc] initWithFrame:CGRectMake(200, 134, 100, 40)];
        [amount setBackgroundColor:[UIColor clearColor]];
        [amount setScrollEnabled:NO];
        [amount setEditable:NO];
        [amount setTextColor:[UIColor DwollaDarkGray]];
        amount.textAlignment = NSTextAlignmentRight;
        [amount setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [amount setText:@"1.00"];
        [top addSubview:amount];
        
        UIImageView* dash2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 174, 300, 2)];
        dash2.image = [UIImage imageNamed:@"dw_dash.png"];
        [dash2 setBackgroundColor:[UIColor grayColor]];
        [top addSubview:dash2];
        
        source = [[UITextView alloc] initWithFrame:CGRectMake(10, 175, 80, 40)];
        [source setFont:[UIFont fontWithName:@"GillSans" size:16]];
        [source setUserInteractionEnabled:NO];
        [source setTextColor:[UIColor DwollaGray]];
        [source setBackgroundColor:[UIColor clearColor]];
        [source setText:@"FROM"];
        [top addSubview:source];
        
        bank = [[UITextView alloc] initWithFrame:CGRectMake(150, 175, 140, 30)];
        [bank setBackgroundColor:[UIColor clearColor]];
        [bank setFont:[UIFont fontWithName:@"GillSans" size:16]];
        [bank setTextColor:[UIColor DwollaGray]];
        [bank setUserInteractionEnabled:NO];
        [top addSubview:bank];
        
        done_button = [[UIButton alloc] initWithFrame:CGRectMake(10, 230, 280, 50)];
        [done_button setImage:[UIImage imageNamed:@"dw_done.png"] forState:UIControlStateNormal];
        [done_button addTarget:self action:@selector(completeTransfer) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:done_button];
    }
    return self;
}

- (void)setEverything:(NSString*)_amount source:(NSString*)_source profile:(UIImage*)_profile bank:(UIImage*)_bank
{
    amount.text = _amount;
    bank.text = _source;
    [profile setImage:_profile];
    [bank_img setImage:_bank];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate* date = [NSDate date];
    [dateFormatter setDateFormat:@"MMM d 'at' hh:mma"];
    
    NSString* dateString = [dateFormatter stringFromDate:date];
    time.text = dateString;
}

- (void)completeTransfer
{
    [[self delegate] doneWithTransfer];
    [self slideOut];
}

- (void)setType:(NSString*)type
{
    name.text = type;
    
    if ([type isEqualToString:@"Deposit"])
    {
        profile.center = CGPointMake(184, 45);
        bank_img.center = CGPointMake(120, 45);
        [source setText:@"FROM"];
    }
    else
    {
        profile.center = CGPointMake(120, 45);
        bank_img.center = CGPointMake(184, 45);
        [source setText:@"TO"];
    }
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
    self.center = CGPointMake(160, 240);
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(-480, 240);
    [UIView commitAnimations];
}

@end
