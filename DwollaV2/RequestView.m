//
//  RequestView.m
//  DwollaV2
//
//  Created by Nick Schulze on 6/3/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "RequestView.h"

@implementation RequestView

@synthesize delegate;
@synthesize youRequested;

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
        
        profile = [[RoundedImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [bg addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(65, 10, 180, 25)];
        [bg addSubview:name];
        
        time = [[UITextView alloc] initWithFrame:CGRectMake(80, 30, 170, 25)];
        [time setBackgroundColor:[UIColor clearColor]];
        [time setFont:[UIFont fontWithName:@"GillSans" size:14]];
        [time setTextColor:[UIColor DwollaOrange]];
        [time setUserInteractionEnabled:NO];
        [bg addSubview:time];
        
        marker = [[UIImageView alloc] initWithFrame:CGRectMake(70, 38, 15, 15)];
        marker.image = [UIImage imageNamed:@"dw_orangeclock.png"];
        [bg addSubview:marker];
        
        totalbg = [[UIImageView alloc] initWithFrame:CGRectMake(250, 20, 50, 25)];
        [totalbg setImage:[UIImage imageNamed:@"dw_distbg.png"]];
        [bg addSubview:totalbg];
        
        total = [[BoldTextView alloc] initWithFrame:CGRectMake(250, 16, 50, 25)];
        [total setTextColor:[UIColor whiteColor]];
        [total setFont:[UIFont fontWithName:@"GillSans-Bold" size:12]];
        [bg addSubview:total];
    }
    return self;
}

- (void)addData:(Request*)request
{
    UIImageView* indicator = [[UIImageView alloc] initWithFrame:CGRectMake(241, 25, 15, 15)];
    [bg addSubview:indicator];
    youRequested = [request youRequested];
    if ([request youRequested])
    {
        name.text = [request dest_name];
        dwolla_id = [request dest_id];
        [indicator setImage:[UIImage imageNamed:@"dw_plus.png"]];
    }
    else
    {
        name.text = [request source_name];
        dwolla_id = [request source_id];
        [indicator setImage:[UIImage imageNamed:@"dw_minus.png"]];
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/d/yyyy HH:mm:ss a"];
    
    NSDate* date = [dateFormatter dateFromString:[request date]];
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

    total.text = [NSString stringWithFormat:@"$%@",[request amount]];
    req_id = [request req_id];
}

- (void)shiftView:(int)i
{
    self.center = CGPointMake(160, 45+(80*i));
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

- (NSString*) req_id
{
    return req_id;
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
    [[self delegate] displayRequest:self];
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end