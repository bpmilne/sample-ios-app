//
//  PinViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "PinView.h"

@interface PinView ()

@end

@implementation PinView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, -200, 320, 140);
        self.backgroundColor = [UIColor clearColor];
        
        top = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 140)];
        [top setBackgroundColor:[UIColor clearColor]];
        [self addSubview:top];
        
        pinviews = [[NSMutableArray alloc] initWithCapacity:4];
        
        UIImageView* pin1 = [[UIImageView alloc] initWithFrame:CGRectMake(19, 50, 63, 63)];
        pin1.backgroundColor = [UIColor clearColor];
        pin1.image = [UIImage imageNamed:@"dw_pwa.png"];
        [top addSubview:pin1];
        [pinviews addObject:pin1];
        
        UIImageView* pin2 = [[UIImageView alloc] initWithFrame:CGRectMake(92, 50, 63, 63)];
        pin2.backgroundColor = [UIColor clearColor];
        pin2.image = [UIImage imageNamed:@"dw_pwb.png"];
        [top addSubview:pin2];
        [pinviews addObject:pin2];
        
        UIImageView* pin3 = [[UIImageView alloc] initWithFrame:CGRectMake(165, 50, 63, 63)];
        pin3.backgroundColor = [UIColor clearColor];
        pin3.image = [UIImage imageNamed:@"dw_pwb.png"];
        [top addSubview:pin3];
        [pinviews addObject:pin3];
        
        UIImageView* pin4 = [[UIImageView alloc] initWithFrame:CGRectMake(238, 50, 63, 63)];
        pin4.backgroundColor = [UIColor clearColor];
        pin4.image = [UIImage imageNamed:@"dw_pwb.png"];
        [top addSubview:pin4];
        [pinviews addObject:pin4];
        
        pin = [[UITextView alloc] init];
    }
    return self;
}

- (UITextView*)textview
{
    return pin;
}

- (void)setPINHidden:(int)i
{
    UIImageView* pinview = [pinviews objectAtIndex:i];
    pinview.backgroundColor = [UIColor clearColor];
    pinview.image = [UIImage imageNamed:@"dw_pws.png"];
}

- (void)setPINActive:(int)i
{
    if (i != 4)
    {
        UIImageView* pinview = [pinviews objectAtIndex:i];
        pinview.backgroundColor = [UIColor clearColor];
        pinview.image = [UIImage imageNamed:@"dw_pwa.png"];
    }
}

- (void)setPINWaiting:(int)i
{
    if(i != 4)
    {
        UIImageView* pinview = [pinviews objectAtIndex:i];
        pinview.backgroundColor = [UIColor clearColor];
        pinview.image = [UIImage imageNamed:@"dw_pwb.png"];
    }
}

- (NSString*)getPIN
{
    return pin.text;
}

- (void)slideDown
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, 70);
    [UIView commitAnimations];
}

- (void)slideDeposit
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(150, 60);
    [UIView commitAnimations];
}

- (void)revert
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, -130);
    [UIView commitAnimations];
}

- (void)destroy
{
    [top removeFromSuperview];
    top = nil;
    [pin removeFromSuperview];
    pin = nil;
    [pinviews removeAllObjects];
    pinviews = nil;
    
    NSArray* subviews = [self subviews];
    
    for (int i = 0; i < [subviews count]; i++)
    {
        UIView* view = [subviews objectAtIndex:i];
        [view removeFromSuperview];
        view = nil;
    }
    
}

- (void)reset
{
    pin.text = @"";
    [self setPINActive:0];
    [self setPINWaiting:1];
    [self setPINWaiting:2];
    [self setPINWaiting:3];
}

@end
