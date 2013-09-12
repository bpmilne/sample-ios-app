//
//  TransactionView.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "TransactionView.h"

@implementation TransactionView

@synthesize delegate;
@synthesize isSend;
@synthesize note;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(10, 10, 300, 70);
        [self setBackgroundColor:[UIColor whiteColor]];
        
        arrowbg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 90, 50)];
        arrowbg.backgroundColor = [UIColor orangeColor];
        [self addSubview:arrowbg];
        
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
        [bg setImage:[UIImage imageNamed:@"dw_contactbg.png"]];
        [self addSubview:bg];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        profile.opaque = YES;
        [bg addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(65, 10, 180, 25)];
        [bg addSubview:name];
        
        time = [[UITextView alloc] initWithFrame:CGRectMake(80, 30, 170, 25)];
        [time setBackgroundColor:[UIColor clearColor]];
        [time setFont:[UIFont fontWithName:@"GillSans" size:14]];
        [time setTextColor:[UIColor DwollaGray]];
        [time setText:@""];
        time.editable = NO;
        [bg addSubview:time];
        
        marker = [[UIImageView alloc] initWithFrame:CGRectMake(70, 38, 15, 15)];
        marker.image = [UIImage imageNamed:@"dw_grayclock.png"];
        [bg addSubview:marker];
        
        totalbg = [[UIImageView alloc] initWithFrame:CGRectMake(235, 20, 65, 25)];
        [totalbg setImage:[UIImage imageNamed:@"dw_distbg.png"]];
        [bg addSubview:totalbg];
        
        total = [[BoldTextView alloc] initWithFrame:CGRectMake(235, 16, 70, 25)];
        [total setFont:[UIFont fontWithName:@"GillSans-Bold" size:12]];
        [total setTextColor:[UIColor whiteColor]];
        [total setTextAlignment:NSTextAlignmentCenter];
        [bg addSubview:total];
    }
    return self;
}

- (void)addData:(Transaction*)transaction
{
    UIImageView* indicator = [[UIImageView alloc] initWithFrame:CGRectMake(226, 25, 15, 15)];
    [bg addSubview:indicator];
    isSend = [transaction isSend];
    if (isSend)
    {
        [indicator setImage:[UIImage imageNamed:@"dw_minus.png"]];
    }
    else
    {
        [indicator setImage:[UIImage imageNamed:@"dw_plus.png"]];
    }
    name.text = [transaction name];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    NSDate* date = [dateFormatter dateFromString:[transaction date]];
    [dateFormatter setDateFormat:@"MMM d 'at' hh:mma"];

    NSString* dateString = [dateFormatter stringFromDate:date];
    realDate = dateString;

    int minutes = [date timeIntervalSinceNow]/60 * -1;
    
    if (minutes > 525949)
    {
        time.text = [NSString stringWithFormat:@"%d yr", minutes/525949];
    }
    else if (minutes > 43829)
    {
        time.text = [NSString stringWithFormat:@"%d mon", minutes/43829];
    }
    else if (minutes > 10080)
    {
        time.text = [NSString stringWithFormat:@"%d wk", minutes/10080];
    }
    else if (minutes > 1440)
    {
        time.text = [NSString stringWithFormat:@"%d d", minutes/1440];
    }
    else if (minutes > 59)
    {
        time.text = [NSString stringWithFormat:@"%d hr", minutes/60];
    }
    else
    {
        time.text = [NSString stringWithFormat:@"%d min", minutes];
    }
    double currency = [[transaction amount] doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *number = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:currency]];
    total.text = [NSString stringWithFormat:@"%@",number];
    dwolla_id = [transaction dwolla_id];
    [self performSelectorInBackground:@selector(AddImageInBackground) withObject:nil];
    note = [transaction note];
}

- (void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
}

- (void)shiftView:(int)i
{
    self.center = CGPointMake(160, 45+(80*i));
}

- (void)AddImageInBackground
{
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/avatar.aspx?u=%@", dwolla_id];
    [profile setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
}

- (UIImage*)profile
{
    return profile.image;
}

- (void)setProfile:(UIImage*)image
{
    profile.image = image;
}

- (NSString*)name
{
    return name.text;
}

- (NSString*)time
{
    return realDate;
}

- (NSString*)total
{
    return total.text;
}

- (NSString*) dwolla_id
{
    return dwolla_id;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self delegate] displayTransaction:self];
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)destroy
{
    [bg removeFromSuperview];
    bg = nil;
    [marker removeFromSuperview];
    marker = nil;
    [arrowbg removeFromSuperview];
    arrowbg = nil;
    [profile removeFromSuperview];
    profile = nil;
    [name removeFromSuperview];
    name = nil;
    [total removeFromSuperview];
    total = nil;
    [totalbg removeFromSuperview];
    totalbg = nil;
    command = nil;
}

@end
