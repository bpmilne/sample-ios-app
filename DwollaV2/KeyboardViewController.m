//
//  KeyboardViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/25/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        mode = 0;
        self.view.frame = CGRectMake(0, screenBounds.size.height, 320, screenBounds.size.height-40);
        self.view.backgroundColor = [UIColor clearColor];
        
        one = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 107, 58)];
        [one setImage:[UIImage imageNamed:@"dw_one.png"] forState:UIControlStateNormal];
        [one addTarget:self action:@selector(appendOne) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:one];
        
        two = [[UIButton alloc] initWithFrame:CGRectMake(107, 0, 106, 58)];
        [two setImage:[UIImage imageNamed:@"dw_two.png"] forState:UIControlStateNormal];
        [self.view addSubview:two];
        [two addTarget:self action:@selector(appendTwo) forControlEvents:UIControlEventTouchUpInside];
        
        three = [[UIButton alloc] initWithFrame:CGRectMake(213, 0, 107, 58)];
        [three setImage:[UIImage imageNamed:@"dw_three.png"] forState:UIControlStateNormal];
        [self.view addSubview:three];
        [three addTarget:self action:@selector(appendThree) forControlEvents:UIControlEventTouchUpInside];
        
        four = [[UIButton alloc] initWithFrame:CGRectMake(0, 58, 107, 58)];
        [four setImage:[UIImage imageNamed:@"dw_four.png"] forState:UIControlStateNormal];
        [self.view addSubview:four];
        [four addTarget:self action:@selector(appendFour) forControlEvents:UIControlEventTouchUpInside];
        
        five = [[UIButton alloc] initWithFrame:CGRectMake(107, 58, 106, 58)];
        [five setImage:[UIImage imageNamed:@"dw_five.png"] forState:UIControlStateNormal];
        [self.view addSubview:five];
        [five addTarget:self action:@selector(appendFive) forControlEvents:UIControlEventTouchUpInside];
        
        six = [[UIButton alloc] initWithFrame:CGRectMake(213, 58, 107, 58)];
        [six setImage:[UIImage imageNamed:@"dw_six.png"] forState:UIControlStateNormal];
        [self.view addSubview:six];
        [six addTarget:self action:@selector(appendSix) forControlEvents:UIControlEventTouchUpInside];
        
        seven = [[UIButton alloc] initWithFrame:CGRectMake(0, 116, 107, 58)];
        [seven setImage:[UIImage imageNamed:@"dw_seven.png"] forState:UIControlStateNormal];
        [self.view addSubview:seven];
        [seven addTarget:self action:@selector(appendSeven) forControlEvents:UIControlEventTouchUpInside];
        
        eight = [[UIButton alloc] initWithFrame:CGRectMake(107, 116, 106, 58)];
        [eight setImage:[UIImage imageNamed:@"dw_eight.png"] forState:UIControlStateNormal];
        [self.view addSubview:eight];
        [eight addTarget:self action:@selector(appendEight) forControlEvents:UIControlEventTouchUpInside];
        
        nine = [[UIButton alloc] initWithFrame:CGRectMake(213, 116, 107, 58)];
        [nine setImage:[UIImage imageNamed:@"dw_nine.png"] forState:UIControlStateNormal];
        [self.view addSubview:nine];
        [nine addTarget:self action:@selector(appendNine) forControlEvents:UIControlEventTouchUpInside];
        
        zerozero = [[UIButton alloc] initWithFrame:CGRectMake(0, 174, 107, 58)];
        [zerozero setImage:[UIImage imageNamed:@"dw_zero2.png"] forState:UIControlStateNormal];
        [self.view addSubview:zerozero];
        [zerozero addTarget:self action:@selector(appendZeroZero) forControlEvents:UIControlEventTouchUpInside];
        
        zero = [[UIButton alloc] initWithFrame:CGRectMake(107, 174, 106, 58)];
        [zero setImage:[UIImage imageNamed:@"dw_zero.png"] forState:UIControlStateNormal];
        [zero addTarget:self action:@selector(appendZero) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:zero];
        
        del = [[UIButton alloc] initWithFrame:CGRectMake(213, 174, 107, 58)];
        [del setImage:[UIImage imageNamed:@"dw_del.png"] forState:UIControlStateNormal];
        [del addTarget:self action:@selector(appendDelete) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:del];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)addTextView:(UITextView*)_textview
{
    textview = _textview;
    mode = 0;
}

- (void)addPINView:(PinView*)_pinview
{
    textview = [_pinview textview];
    pin = _pinview;
    mode = 1;
}

- (void)appendOne
{
    textview.text = [textview.text stringByAppendingString:@"1"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendTwo
{
    textview.text = [textview.text stringByAppendingString:@"2"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendThree
{
    textview.text = [textview.text stringByAppendingString:@"3"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendFour
{
    textview.text = [textview.text stringByAppendingString:@"4"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendFive
{
    textview.text = [textview.text stringByAppendingString:@"5"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendSix
{
    textview.text = [textview.text stringByAppendingString:@"6"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendSeven
{
    textview.text = [textview.text stringByAppendingString:@"7"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendEight
{
    textview.text = [textview.text stringByAppendingString:@"8"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendNine
{
    textview.text = [textview.text stringByAppendingString:@"9"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendZeroZero
{
    textview.text = [textview.text stringByAppendingString:@"00"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendZero
{
    textview.text = [textview.text stringByAppendingString:@"0"];
    if (mode == 0)
    {
        [self cleanup];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)appendDelete
{
    textview.text = [textview.text substringToIndex:[textview.text length]-1];
    if (mode == 0)
    {
        [self cleanupDel];
    }
    else
    {
        [self pin:[textview.text length]];
    }
}

- (void)cleanup
{
    int length = [textview.text length]-1;
    NSString* decimalholder = [textview.text substringFromIndex:1];

    NSMutableString* holder = [NSMutableString stringWithString:[decimalholder stringByReplacingOccurrencesOfString:@"." withString:@""]];

    if ([holder characterAtIndex:0] == '0')
    {
        [holder deleteCharactersInRange:NSMakeRange(0, 1)];
        length = length - 1;
    }
    [holder insertString:@"." atIndex:length-3];
    [holder insertString:@"$" atIndex:0];
    
    textview.text = holder;
}

- (void)cleanupDel
{
    int length = [textview.text length]-1;
    NSString* decimalholder = [textview.text substringFromIndex:1];
    NSMutableString* holder = [NSMutableString stringWithString:decimalholder];
    [holder deleteCharactersInRange:NSMakeRange(length-2, 1)];
    [holder insertString:@"." atIndex:length-3];
    if (length == 3 && [holder characterAtIndex:0] == '.')
    {
        holder = [NSMutableString stringWithString:[@"0" stringByAppendingString:holder]];
    }
    [holder insertString:@"$" atIndex:0];
    textview.text = holder;
    
}

- (void)pin:(int)length
{
        if (length < 5)
        {
        for(int i = 0; i < length; i++)
        {
            [pin setPINHidden:i];
        }

        [pin setPINActive:length];

        for(int i = 3; i > length; i--)
        {
            [pin setPINWaiting:i];
        }
    }
}

- (void)destroy
{
    NSArray* subviews = [self.view subviews];
    
    for (int i = 0; i < [subviews count]; i++)
    {
        UIView* view = [subviews objectAtIndex:i];
        [view removeFromSuperview];
        view = nil;
    }
    
    [textview removeFromSuperview];
    textview = nil;
    
    [pin removeFromSuperview];
    [pin destroy];
    pin = nil;
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    if (screenBounds.size.height == 568)
    {
        self.view.center = CGPointMake(160, screenBounds.size.height-28);
    }
    else
    {
        self.view.center = CGPointMake(160, screenBounds.size.height-72);
    }
    [UIView commitAnimations];
}

- (void)slideInDeposit
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:.15];
//    [UIView setAnimationDuration:.4];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDelegate:self];
    if (screenBounds.size.height == 568)
    {
        self.view.center = CGPointMake(160, screenBounds.size.height-28);
    }
    else
    {
        self.view.center = CGPointMake(160, screenBounds.size.height-70);
    }
//    [UIView commitAnimations];
}

- (void)slideInRequest
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    if (screenBounds.size.height == 568)
    {
        self.view.center = CGPointMake(160, screenBounds.size.height-28);
    }
    else
    {
        self.view.center = CGPointMake(160, screenBounds.size.height-90);
    }
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, screenBounds.size.height+232);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
