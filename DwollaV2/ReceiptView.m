//
//  ReceiptViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "ReceiptView.h"

@interface ReceiptView ()

@end

@implementation ReceiptView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(320, 0, 320, 480);
        self.backgroundColor = [UIColor DwollaGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 50, 300, 340)];
        top.backgroundColor = [UIColor whiteColor];
        [self addSubview:top];
        
        profile = [[RoundedImageView alloc] initWithFrame:CGRectMake(125, 10, 50, 50)];
        [top addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(50, 60, 200, 35)];
        [name setFont:[UIFont fontWithName:@"GillSans-Bold" size:16]];
        name.textAlignment = NSTextAlignmentCenter;
        [top addSubview:name];
        
        timebg = [[UIImageView alloc] initWithFrame:CGRectMake(55, 90, 190, 25)];
        timebg.image = [UIImage imageNamed:@"dw_timebanner.png"];
        [timebg setBackgroundColor:[UIColor clearColor]];
        [top addSubview:timebg];
        
        time = [[BoldTextView alloc] initWithFrame:CGRectMake(70, 86, 180, 25)];
        [time setTextColor:[UIColor whiteColor]];
        [top addSubview:time];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash];
        
        total = [[BoldTextView alloc] initWithFrame:CGRectMake(5, 134, 120, 25)];
        [total setText:@"TOTAL"];
        [top addSubview:total];
        
        amount = [[LightTextView alloc] initWithFrame:CGRectMake(200, 128, 100, 40)];
        amount.textAlignment = NSTextAlignmentRight;
        [amount setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [top addSubview:amount];
        
        UIImageView* dash2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 170, 300, 2)];
        dash2.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash2];
        
        note_button = [[UIButton alloc] initWithFrame:CGRectMake(10, 190, 20, 20)];
        [note_button setImage:[UIImage imageNamed:@"dw_note.png"] forState:UIControlStateNormal];
        [top addSubview:note_button];
        
        note = [[UITextView alloc] initWithFrame:CGRectMake(30, 185, 235, 60)];
        [note setTextColor:[UIColor DwollaDarkGray]];
        [note setUserInteractionEnabled:NO];
        [note setBackgroundColor:[UIColor clearColor]];
        [top addSubview:note];
        
        BoldTextView* show = [[BoldTextView alloc] initWithFrame:CGRectMake(20, 310, 260, 25)]; 
        [show setText:@"Please show this receipt upon request."];
        [show setFont:[UIFont fontWithName:@"GillSans-Bold" size:12]];
        show.textAlignment = NSTextAlignmentCenter;
        [top addSubview:show];
    }
    return self;
}

-(void)setEverything:(UIImage*)_profile name:(NSString*)_name amount:(NSString*)_amount note:(NSString *)_note type:(NSString*)_type
{
    profile.image = _profile;
    name.text = _name;
    amount.text = [NSString stringWithFormat:@"$%@", _amount];
    note.text = _note;
    [total setText:_type];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate* date = [NSDate date];
    [dateFormatter setDateFormat:@"MMM d 'at' hh:mma"];
    
    NSString* dateString = [dateFormatter stringFromDate:date];
    time.text = dateString;
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, 240);
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(480, 240);
    [UIView commitAnimations];
}


@end
