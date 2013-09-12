//
//  TransferViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "TransferViewController.h"

@interface TransferViewController ()

@end

@implementation TransferViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(0, screenBounds.size.height*2, 320, screenBounds.size.height+200);
        self.view.backgroundColor = [UIColor DwollaClearGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 10, 300, 188)];
        top.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:top];
        
        header = [[RoundedView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        header.backgroundColor = [UIColor whiteColor];
        [top addSubview:header];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [header addSubview:dash];
        
        profile = [[RoundedImageView alloc] initWithFrame:CGRectMake(64, 60, 50, 50)];
        [top addSubview:profile];
        
        bank = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 50, 50)];
        bank.backgroundColor = [UIColor clearColor];
        [bank setImage:[UIImage imageNamed:@"dw_bankr.png"]];
        [top addSubview:bank];
        
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(65, 76, 20, 20)];
        [arrow setImage:[UIImage imageNamed:@"dw_arrow.png"]];
        [top addSubview:arrow];
        
        transfer = [[BoldTextView alloc] initWithFrame:CGRectMake(35, 10, 230, 25)];
        transfer.textAlignment = NSTextAlignmentCenter;
        [transfer setText:@"DEPOSIT"];
        [header addSubview:transfer];
        
        total = [[LightTextView alloc] initWithFrame:CGRectMake(165, 65, 130, 40)];
        [total setFont:[UIFont fontWithName:@"GillSans-Light" size:30]];
        total.textAlignment = NSTextAlignmentRight;
        [total setText:@"$0.00"];
        [top addSubview:total];
        
        cont = [[UIButton alloc] initWithFrame:CGRectMake(10, 130, 280, 40)];
        [cont setImage:[UIImage imageNamed:@"dw_continue.png"] forState:UIControlStateNormal];
        [cont addTarget:self action:@selector(showSource) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:cont];
        
        source = [[SourceView alloc] init];
        [self.view addSubview:source];
        [source setDelegate:self];
        
        int offset = 0;
        if (screenBounds.size.height == 568)
        {
            offset = 40;
        }
        pin_background = [[RoundedView alloc] initWithFrame:CGRectMake(-310, 10, 300, 190 + offset)];
        pin_background.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:pin_background];
        
        confirm_b = [[UIButton alloc] initWithFrame:CGRectMake(10, 130+offset, 280, 40)];
        [confirm_b setImage:[UIImage imageNamed:@"dw_confirm.png"] forState:UIControlStateNormal];
        [confirm_b addTarget:self action:@selector(showConfirm) forControlEvents:UIControlEventTouchUpInside];
        [pin_background addSubview:confirm_b];
        
        keyboard = [[KeyboardViewController alloc] init];
        [keyboard addTextView:total];
        [keyboard slideInDeposit];
        [self.view addSubview:keyboard.view];
        
        pin = [[PinView alloc] init];
        [pin slideDeposit];
        [pin_background addSubview:pin];
        
        header2 = [[RoundedView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        header2.backgroundColor = [UIColor whiteColor];
        [pin_background addSubview:header2];
        
        BoldTextView* transfer2 = [[BoldTextView alloc] initWithFrame:CGRectMake(35, 10, 230, 25)];
        transfer2.textAlignment = NSTextAlignmentCenter;
        [transfer2 setText:@"PIN"];
        [header2 addSubview:transfer2];
        
        UIImageView* dash2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 300, 2)];
        dash2.image = [UIImage imageNamed:@"dw_dash.png"];
        [header2 addSubview:dash2];
        
        close = [[UIButton alloc] initWithFrame:CGRectMake(265, 15, 20, 20)];
        [close setImage:[UIImage imageNamed:@"dw_x.png"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        close.backgroundColor = [UIColor clearColor];
        [header addSubview:close];
        
        UIButton* close2 = [[UIButton alloc] initWithFrame:CGRectMake(265, 15, 20, 20)];
        [close2 setImage:[UIImage imageNamed:@"dw_x.png"] forState:UIControlStateNormal];
        [close2 addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        close2.backgroundColor = [UIColor clearColor];
        [header2 addSubview:close2];
        
       UIButton* back2 = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
        [back2 setImage:[UIImage imageNamed:@"dw_back.png"] forState:UIControlStateNormal];
        [back2 addTarget:self action:@selector(hidePin) forControlEvents:UIControlEventTouchUpInside];
        back2.backgroundColor = [UIColor clearColor];
        [header2 addSubview:back2];
        
        confirm = [[TransferConfirmView alloc] init];
        [confirm setDelegate:self];
        [self.view addSubview:confirm];
        
        slip = [[SlipView alloc] init];
        [slip setDelegate:self];
        [self.view addSubview:slip];
    }
    return self;
}

- (void)addCommandCenter:(CommandCenter*) _command
{
    command = _command;
}

- (void)getSources
{
    [source populateWithSources:[command userSources]];
    profile.image = [command userImage];
}

- (void)setAsDeposit
{
    isDeposit = YES;
    [transfer setText:@"DEPOSIT"];
    [source setAsDeposit];
    profile.center = CGPointMake(105, 85);
    bank.center = CGPointMake(45, 85);
}

- (void)setAsWithdraw
{
    isDeposit = NO;
    [transfer setText:@"WITHDRAW"];
    [source setAsWithdraw];
    profile.center = CGPointMake(45, 85);
    bank.center = CGPointMake(105, 85);
}

- (void)showSource
{
    [source slideIn];
    [keyboard slideOut];
}

- (void)showPin
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    pin_background.center = CGPointMake(160, pin_background.frame.size.height/2 + 10);
    [UIView commitAnimations];
    [keyboard slideInDeposit];
    [transfer setText:@"PIN"];

    [keyboard addPINView:pin];
}

- (void)hidePin
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    pin_background.center = CGPointMake(-480, pin_background.frame.size.height/2 + 10);
    [UIView commitAnimations];
    [keyboard slideOut];
    if (isDeposit)
    {
        [transfer setText:@"DEPOSIT SOURCE"];
    }
    else
    {
        [transfer setText:@"WITHDRAWAL DESTINATION"];
    }
}

- (void)showConfirm
{
    if (isDeposit)
    {
        [transfer setText:@"CONFIRM DEPOSIT"];
        [confirm setAsDeposit];
    }
    else
    {
        [transfer setText:@"CONFIRM WITHDRAWAL"];
        [confirm setAsWithdrawal];
    }

    [confirm setEverything:total.text source:[source source_name] profile:profile.image bank:bank.image];
    [confirm slideIn];
}

- (void)hideConfirm
{

    [confirm slideOut];
    [self.view bringSubviewToFront:header];
}

- (void)completeTransfer
{
    NSString* response;
    if (isDeposit)
    {
        response = [command depositMoney:[pin getPIN] source_id:[source source_id] amount:[total.text substringFromIndex:1]];
        [slip setType:@"Deposit"];
    }
    else
    {
       response = [command withdrawMoney:[pin getPIN] source_id:[source source_id] amount:[total.text substringFromIndex:1]];
        [slip setType:@"Withdrawal"];
    }
    if (![response isEqualToString:@"invalid"])
    {
        [slip setEverything:total.text source:[source source_name] profile:profile.image bank:bank.image];
        [self.view bringSubviewToFront:header];
        [slip slideIn];
    }
    else
    {
        [self hideConfirm];
        [self hidePin];
    }
}

- (void)doneWithTransfer
{
    [self slideOut];
    [confirm slideOut];
    [self hidePin];
    [source slideOut];
    [keyboard slideInDeposit];
}

- (void)hideTransfer
{
    [[self delegate] closeTransfer];
}

- (void)showMain
{
    if (isDeposit)
    {
        [transfer setText:@"DEPOSIT"];
    }
    else
    {
        [transfer setText:@"WITHDRAW"];

    }
    [keyboard slideInDeposit];
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, (self.view.frame.size.height/2));
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideTransfer)];
    self.view.center = CGPointMake(160, screenBounds.size.height*2);
    [UIView commitAnimations];
}

- (void)destroy
{
    [keyboard destroy];
    [keyboard removeFromParentViewController];
    [keyboard.view removeFromSuperview];
    keyboard = nil;
    
    [pin destroy];
    [pin removeFromSuperview];
    pin = nil;
    
    [confirm destroy];
    [confirm removeFromSuperview];
    confirm = nil;
    
    [slip destroy];
    [slip removeFromSuperview];
    slip = nil;
    
    [source destroy];
    [source removeFromSuperview];
    source = nil;
    
    NSArray* subviews = [self.view subviews];
    
    for (int i = 0; i < [subviews count]; i++)
    {
        UIView* view = [subviews objectAtIndex:i];
        [view removeFromSuperview];
        view = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
