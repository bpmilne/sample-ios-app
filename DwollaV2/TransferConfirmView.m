//
//  TransferConfirmView.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "TransferConfirmView.h"

@implementation TransferConfirmView

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(-320, 0, 320, 480);
        self.backgroundColor = [UIColor DwollaClearGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 10, 300, 220)];
        top.backgroundColor = [UIColor whiteColor];
        [self addSubview:top];
        
        profile = [[RoundedImageView alloc] initWithFrame:CGRectMake(64, 60, 50, 50)];
        [top addSubview:profile];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash];
        
        UIButton* close = [[UIButton alloc] initWithFrame:CGRectMake(265, 15, 20, 20)];
        [close setImage:[UIImage imageNamed:@"dw_x.png"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closeTransfer) forControlEvents:UIControlEventTouchUpInside];
        close.backgroundColor = [UIColor clearColor];
        [top addSubview:close];
        
        UIButton* back = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
        [back setImage:[UIImage imageNamed:@"dw_back.png"] forState:UIControlStateNormal];
        back.backgroundColor = [UIColor clearColor];
        [back addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:back];
        
        bank_img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 50, 50)];
        bank_img.backgroundColor = [UIColor clearColor];
        [bank_img setImage:[UIImage imageNamed:@"dw_bankr.png"]];
        [top addSubview:bank_img];
        
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(65, 76, 20, 20)];
        [arrow setImage:[UIImage imageNamed:@"dw_arrow.png"]];
        [top addSubview:arrow];
        
        title = [[BoldTextView alloc] initWithFrame:CGRectMake(60, 10, 180, 25)];
        title.textAlignment = NSTextAlignmentCenter;
        [title setText:@"CONFIRM DEPOSIT"];
        [top addSubview:title];
        
        amount = [[LightTextView alloc] initWithFrame:CGRectMake(200, 60, 100, 50)];
        [amount setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [amount setText:@"0.00"];
        [top addSubview:amount];
        
        source = [[UITextView alloc] initWithFrame:CGRectMake(10, 115, 80, 40)];
        [source setFont:[UIFont fontWithName:@"GillSans" size:16]];
        [source setUserInteractionEnabled:NO];
        [source setTextColor:[UIColor DwollaGray]];
        [source setText:@"FROM"];
        [top addSubview:source];
        
        bank = [[UITextView alloc] initWithFrame:CGRectMake(150, 115, 140, 30)];
        [bank setBackgroundColor:[UIColor clearColor]];
        [bank setFont:[UIFont fontWithName:@"GillSans" size:16]];
        [bank setTextColor:[UIColor DwollaGray]];
        [bank setUserInteractionEnabled:NO];
        [top addSubview:bank];
        
        done_button = [[UIButton alloc] initWithFrame:CGRectMake(10, 158, 280, 50)];
        [done_button setImage:[UIImage imageNamed:@"dw_compdep.png"] forState:UIControlStateNormal];
        [done_button addTarget:self action:@selector(completeTransfer) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:done_button];
    }
    return self;
}

- (void)completeTransfer
{
    [[self delegate] completeTransfer];
}

- (void)setEverything:(NSString*)_amount source:(NSString*)_source profile:(UIImage*)_profile bank:(UIImage*)_bank
{
    amount.text = _amount;
    bank.text = _source;
    [profile setImage:_profile];
    [bank_img setImage:_bank];
}

- (void)setAsDeposit
{
    [title setText:@"CONFIRM DEPOSIT"];
    isDeposit = YES;
    [done_button setTitle:@"COMPLETE DEPOSIT" forState:UIControlStateNormal];
    [done_button setImage:[UIImage imageNamed:@"dw_compdep.png"] forState:UIControlStateNormal];
    profile.center = CGPointMake(105, 85);
    bank_img.center = CGPointMake(45, 85);
}

- (void)setAsWithdrawal
{
    [title setText:@"CONFIRM WITHDRAWAL"];
    isDeposit = NO;
    [done_button setTitle:@"COMPLETE WITHDRAWAL" forState:UIControlStateNormal];
    [done_button setImage:[UIImage imageNamed:@"dw_compwd.png"] forState:UIControlStateNormal];
    profile.center = CGPointMake(45, 85);
    bank_img.center = CGPointMake(105, 85);
}

- (void)closeTransfer
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
