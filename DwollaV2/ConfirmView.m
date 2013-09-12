//
//  ConfirmViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "ConfirmView.h"

@interface ConfirmView ()

@end

@implementation ConfirmView

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(320, 0, 320, 510);
        self.backgroundColor = [UIColor DwollaGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 50, 300, 290)];
        top.backgroundColor = [UIColor whiteColor];
        [self addSubview:top];
        
        profile = [[RoundedImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [top addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(65, 20, 200, 25)];
        [top addSubview:name];
        
        UIImageView* dash2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 300, 2)];
        dash2.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash2];
        
        total = [[BoldTextView alloc] initWithFrame:CGRectMake(10, 80, 100, 35)];
        [total setText:@"TOTAL"];
        [top addSubview:total];
        
        amount = [[LightTextView alloc] initWithFrame:CGRectMake(190, 72, 100, 45)];
        amount.textAlignment = NSTextAlignmentRight;
        [amount setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [amount setText:@"0.00"];
        [top addSubview:amount];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash];
        
        note_button = [[UIButton alloc] initWithFrame:CGRectMake(20, 135, 20, 20)];
        [note_button setImage:[UIImage imageNamed:@"dw_note.png"] forState:UIControlStateNormal];
        [note_button addTarget:self action:@selector(note) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:note_button];
        
        note = [[UITextView alloc] initWithFrame:CGRectMake(40, 130, 235, 60)];
        [note setUserInteractionEnabled:NO];
        [note setBackgroundColor:[UIColor clearColor]];
        [note setTextColor:[UIColor DwollaDarkGray]];
        [top addSubview:note];
        
        complete = [[UIButton alloc] initWithFrame:CGRectMake(10, 230, 280, 50)];
        [complete setImage:[UIImage imageNamed:@"dw_compay.png"] forState:UIControlStateNormal];
        [complete addTarget:self action:@selector(receipt) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:complete];
        
        isSend = YES;
    }
    return self;
}

- (void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
}

- (void)setEverything:(UIImage*)image name:(NSString*)_name total:(NSString*)_amount dwolla_id:(NSString*)d_id pin:_pin note:(NSString*)_note;
{
    profile.image = image;
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
    name.text = _name;
    amount.text = _amount;
    dwolla_id = d_id;
    pin = _pin;
    note.text = _note;
}

- (void)setAsRequest
{
    isSend = NO;
    [complete setTitle:@"COMPLETE REQUEST" forState:UIControlStateNormal];
    [complete setImage:[UIImage imageNamed:@"dw_comreq.png"] forState:UIControlStateNormal];
}

- (void)setAsSend
{
    isSend = YES;
    [complete setTitle:@"COMPLETE PAYMENT" forState:UIControlStateNormal];
    [complete setImage:[UIImage imageNamed:@"dw_compay.png"] forState:UIControlStateNormal];
}

- (void)receipt
{
    NSString* _amount = [amount.text substringFromIndex:1];
    BOOL worked;
    if (isSend)
    {
       worked = [command sendMoney:pin dwolla_id:dwolla_id amount:_amount name:name.text image:profile.image note:note.text];
    }
    else
    {
       worked = [command requestMoney:pin dwolla_id:dwolla_id amount:_amount name:name.text image:profile.image note:note.text];
    }
    if (!worked)
    {
        [[self delegate] backToPin];
    }
    else
    {
        [self performSelector:@selector(reset) withObject:nil afterDelay:1.0];
    }
}

- (void)note
{
    [[self delegate] note];
}

- (void)setNote:(NSString*)string
{
    note.text = string;
}

-(void)destroy
{
    [top removeFromSuperview];
    top = nil;
    [topbg removeFromSuperview];
    topbg = nil;
    [profile removeFromSuperview];
    profile = nil;
    [name removeFromSuperview];
    name = nil;
    [total removeFromSuperview];
    total = nil;
    [amount removeFromSuperview];
    amount = nil;
    [note_button removeFromSuperview];
    note_button = nil;
    [note removeFromSuperview];
    note = nil;
    [complete removeFromSuperview];
    complete = nil;
    command = nil;
    dwolla_id = nil;
    pin = nil;
    delegate = nil;
}

- (void)reset
{
    [[self delegate] detailReset];
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, 255);
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(480, 255);
    [UIView commitAnimations];
}
@end
